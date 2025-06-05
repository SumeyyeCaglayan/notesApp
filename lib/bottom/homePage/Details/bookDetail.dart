import 'package:flutter/material.dart';

class BookDetailPage extends StatefulWidget {
  final Map<String, dynamic> book;

  const BookDetailPage({super.key, required this.book});

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  int selectedStars = 0;

  Widget _buildInfoCard(String title, String value) {
    return Column(
      children: [
        Text(title, style: TextStyle(fontSize: 14, color: Colors.grey)),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildTag(String tag) {
    return Chip(
      label: Text(tag),
      backgroundColor: Colors.grey[200],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(70),
        side: BorderSide(width: 2),
      ),
    );
  }

  Widget _buildBookCard(String title, String rating) {
    return Container(
      width: 100,
      margin: EdgeInsets.only(right: 8.0),
      child: Column(
        children: [
          Image.asset('assets/images/korluk.png', width: 80, height: 100),
          SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12),
          ),
          Text(rating, style: TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildReview(String reviewer, int rating, String comment) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(backgroundColor: Colors.grey[300], radius: 20),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    reviewer,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: List.generate(
                      rating,
                      (index) =>
                          Icon(Icons.star, size: 14, color: Colors.amber),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(comment, style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  bool isFav = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book['title'] ?? 'Kitap Detayı'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              setState(() {
                isFav = !isFav;
              });
            },
            icon: Icon(
              isFav ? Icons.favorite : Icons.favorite_border,
              color: isFav ? Colors.red : Colors.grey,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/yazar${widget.book['id'] ?? 'default'}.png',
                    width: 150,
                    height: 200,
                  ),
                  SizedBox(height: 16),
                  Text(
                    widget.book['title'] ?? 'Kitap Adı',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    widget.book['author'] ?? 'Yazar Adı',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 245, 243, 243),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildInfoCard(
                    "Oylama",
                    widget.book['ratings'] ?? 'Yıldız Sayısı',
                  ),
                  _buildInfoCard(
                    "Sayfa Sayı",
                    widget.book['sayfa_sayisi'] ?? 'Sayfa Sayısı',
                  ),
                  _buildInfoCard("Dil", widget.book['language'] ?? 'Dil'),
                  _buildInfoCard(
                    "Yazar İsmi",
                    widget.book['author'] ?? 'Yazar',
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Text(
              "Açıklama",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              widget.book['description'] ?? 'Açıklama mevcut değil.',
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
            SizedBox(height: 16),
            Text(
              "Etiketler",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              children: [
                _buildTag("#eğitim"),
                _buildTag("#tarih"),
                _buildTag("#tıp"),
                _buildTag("#bilim"),
                _buildTag("#mühendislik"),
              ],
            ),
            SizedBox(height: 16),
            Text(
              "Benzer Kitaplar",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            SizedBox(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildBookCard("Benzer 1", ""),
                  _buildBookCard("Benzer 2", ""),
                  _buildBookCard("Benzer 3", ""),
                ],
              ),
            ),
            SizedBox(height: 16),
            Text(
              "Yorumlar",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            _buildReview("Yorumcu 1", 5, "Harika bir kitap!"),
            _buildReview("Yorumcu 2", 2, "Fena değil."),
            SizedBox(height: 16),
            Text(
              "Oylama & Yorum",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              children: List.generate(
                5,
                (index) => IconButton(
                  onPressed: () {
                    setState(() {
                      selectedStars = index + 1;
                    });
                  },
                  icon: Icon(
                    index < selectedStars ? Icons.star : Icons.star_border,
                  ),
                  color: Colors.red,
                ),
              ),
            ),
            SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                hintText: "Düşüncelerini bekliyoruz :)",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Kitap satın alma işlemleri burada yapılabilir
              },
              child: Text("Satın Al"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
