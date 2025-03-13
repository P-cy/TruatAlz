import 'package:flutter/material.dart';
import 'package:truat_alz/pages/url_Widget.dart';

class AlzheimersContentScreen extends StatelessWidget {
  const AlzheimersContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "โรคอัลไซเมอร์",
          style: TextStyle(
            color: Color(0xFF2C3E50),
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color(0xFF2C3E50),
              size: 30,
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildHeader(),
          const SizedBox(height: 16),
          _buildInfoCard(
            title: 'โรคอัลไซเมอร์คืออะไร?',
            content:
                'โรคอัลไซเมอร์ เป็นโรคที่ทำให้สมองเสื่อมชนิดหนึ่ง ซึ่งเกิดจากการตายของเซลล์ประสาทในสมอง ส่งผลให้ผู้ป่วยมีอาการหลงลืม สับสน และมีการเปลี่ยนแปลงทางพฤติกรรมอย่างค่อยเป็นค่อยไป',
            icon: Icons.help_outline,
          ),
          _buildInfoCard(
            title: 'อาการของโรคอัลไซเมอร์',
            content:
                '• หลงลืมข้อมูลที่เพิ่งเรียนรู้\n• ลืมวันเวลาและสถานที่\n• สื่อสารลำบาก หาคำพูดไม่ได้\n• วางของผิดที่แล้วหาไม่เจอ\n• มีปัญหาในการตัดสินใจ\n• อารมณ์และพฤติกรรมเปลี่ยนไป\n• ถอนตัวจากสังคมและงานอดิเรก',
            icon: Icons.warning_amber_rounded,
          ),
          _buildInfoCard(
            title: 'วิธีการดูแลผู้ป่วยอัลไซเมอร์',
            content:
                '1. จัดสภาพแวดล้อมให้ปลอดภัย\n2. สร้างกิจวัตรประจำวันที่คงเส้นคงวา\n3. ให้ความรักและความอดทน\n4. ฝึกให้ผู้ป่วยทำกิจกรรมเพื่อกระตุ้นความจำ\n5. ดูแลโภชนาการและการออกกำลังกาย\n6. ใช้สิ่งที่ช่วยเตือนความจำ เช่น ปฏิทิน นาฬิกา\n7. พบแพทย์อย่างสม่ำเสมอ',
            icon: Icons.favorite,
          ),
          _buildInfoCard(
            title: 'ปัจจัยเสี่ยงของการเกิดโรคอัลไซเมอร์',
            content:
                '• อายุที่เพิ่มขึ้น (พบบ่อยในผู้สูงอายุ 65 ปีขึ้นไป)\n• ประวัติครอบครัวและพันธุกรรม\n• ภาวะความดันโลหิตสูง\n• โรคเบาหวาน\n• ระดับคอเลสเตอรอลสูง\n• การสูบบุหรี่\n• ภาวะน้ำหนักเกินหรือโรคอ้วน',
            icon: Icons.analytics_outlined,
          ),
          _buildInfoCard(
            title: 'การวินิจฉัยโรคอัลไซเมอร์',
            content:
                '• การซักประวัติและตรวจร่างกาย\n• การทดสอบความจำและความสามารถในการคิด\n• การตรวจเลือด\n• การตรวจภาพสมองด้วย MRI หรือ CT scan\n• การตรวจน้ำไขสันหลัง (ในบางกรณี)',
            icon: Icons.medical_services_outlined,
          ),
          _buildInfoCard(
            title: 'การรักษาโรคอัลไซเมอร์',
            content:
                'ปัจจุบันยังไม่มีวิธีรักษาให้หายขาด แต่มีการรักษาเพื่อชะลออาการและเพิ่มคุณภาพชีวิต ได้แก่\n• การใช้ยาเพื่อชะลออาการ\n• การรักษาทางจิตวิทยาและพฤติกรรม\n• การทำกิจกรรมบำบัด\n• การออกกำลังกายเพื่อเพิ่มการไหลเวียนเลือดไปสู่สมอง',
            icon: Icons.healing,
          ),
          const SizedBox(height: 16),
          _buildContactButton(context),
          const SizedBox(height: 32),
          ReferenceFooter(
            references: [
              ReferenceItem(
                linkText:
                    'โรงพยาบาล พญาไท 2.(2563). ดูแลผู้ป่วยอัลไซเมอร์อย่างไร ให้ทั้งตนเองและผู้ป่วยมีความสุข. สืบค้นจาก https://www.phyathai.com/th/article/2190-how-to-care-for-alzheimers-patients_ptn?srsltid=AfmBOooZ7Nsd0Ry6LwzmmQVCnoUVFFp-G9nXMQACdy_8sfJty03OGDhN',
                url: Uri.parse(
                    'https://www.phyathai.com/th/article/2190-how-to-care-for-alzheimers-patients_ptn?srsltid=AfmBOooZ7Nsd0Ry6LwzmmQVCnoUVFFp-G9nXMQACdy_8sfJty03OGDhN'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            'assets/img/slide1.jpg',
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'แนวทางการวิเคราะห์\nและดูแลผู้ป่วยโรคอัลไซเมอร์',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2C6EB5),
          ),
        ),
        const Divider(thickness: 1, height: 32),
      ],
    );
  }

  Widget _buildInfoCard({
    required String title,
    required String content,
    required IconData icon,
  }) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: const Color(0xFF2C6EB5), size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            Text(
              content,
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('ติดต่อแพทย์ผู้เชี่ยวชาญ'),
            content: const Text(
              'หากคุณหรือคนที่คุณรู้จักมีอาการที่น่าสงสัยว่าเป็นโรคอัลไซเมอร์ โปรดติดต่อแพทย์ผู้เชี่ยวชาญเพื่อรับการตรวจวินิจฉัยและคำแนะนำที่เหมาะสม',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('ปิด'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  // โค้ดสำหรับการโทรหาโรงพยาบาล
                },
                child: const Text('โทร 1772'),
              ),
            ],
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green[800],
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.phone, color: Colors.white),
          SizedBox(width: 8),
          Text(
            'ปรึกษาแพทย์ผู้เชี่ยวชาญ',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
