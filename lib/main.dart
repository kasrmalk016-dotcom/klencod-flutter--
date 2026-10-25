
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const DuaApp());

const green = Color(0xFF073B32);
const gold = Color(0xFFE3BD69);

class DuaApp extends StatelessWidget {
  const DuaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'أدعية المسلم',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF5F2E9),
        colorScheme: ColorScheme.fromSeed(seedColor: green),
        appBarTheme: const AppBarTheme(
          backgroundColor: green,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),
      home: const DuaHome(),
    );
  }
}

class Dua {
  final String category, title, text, source;
  const Dua(this.category, this.title, this.text, this.source);
}

const duas = <Dua>[
  Dua('الاستيقاظ', 'دعاء الاستيقاظ',
      'الحمد لله الذي أحيانا بعدما أماتنا وإليه النشور.',
      'صحيح البخاري'),
  Dua('النوم', 'دعاء النوم',
      'باسمك اللهم أموت وأحيا.', 'صحيح البخاري'),
  Dua('الصباح', 'سيد الاستغفار',
      'اللهم أنت ربي لا إله إلا أنت، خلقتني وأنا عبدك، وأنا على عهدك ووعدك ما استطعت، أعوذ بك من شر ما صنعت، أبوء لك بنعمتك علي، وأبوء بذنبي فاغفر لي، فإنه لا يغفر الذنوب إلا أنت.',
      'صحيح البخاري'),
  Dua('المساء', 'دعاء المساء',
      'أمسينا وأمسى الملك لله، والحمد لله، لا إله إلا الله وحده لا شريك له، له الملك وله الحمد وهو على كل شيء قدير.',
      'صحيح مسلم'),
  Dua('المنزل', 'دخول المنزل',
      'بسم الله ولجنا، وبسم الله خرجنا، وعلى ربنا توكلنا.',
      'سنن أبي داود'),
  Dua('المسجد', 'دخول المسجد',
      'اللهم افتح لي أبواب رحمتك.', 'صحيح مسلم'),
  Dua('المسجد', 'الخروج من المسجد',
      'اللهم إني أسألك من فضلك.', 'صحيح مسلم'),
  Dua('الطعام', 'قبل الطعام',
      'بسم الله.', 'سنن أبي داود والترمذي'),
  Dua('الطعام', 'بعد الطعام',
      'الحمد لله الذي أطعمني هذا ورزقنيه من غير حول مني ولا قوة.',
      'سنن أبي داود والترمذي'),
  Dua('السفر', 'دعاء السفر',
      'سبحان الذي سخر لنا هذا وما كنا له مقرنين وإنا إلى ربنا لمنقلبون.',
      'صحيح مسلم'),
  Dua('الكرب', 'دعاء الكرب',
      'لا إله إلا الله العظيم الحليم، لا إله إلا الله رب العرش العظيم، لا إله إلا الله رب السماوات ورب الأرض ورب العرش الكريم.',
      'صحيح البخاري'),
  Dua('الهم', 'دعاء الهم والحزن',
      'اللهم إني أعوذ بك من الهم والحزن، والعجز والكسل، والبخل والجبن، وضلع الدين وغلبة الرجال.',
      'صحيح البخاري'),
  Dua('الشفاء', 'دعاء للمريض',
      'اللهم رب الناس، أذهب البأس، اشف أنت الشافي، لا شفاء إلا شفاؤك، شفاء لا يغادر سقما.',
      'صحيح البخاري'),
  Dua('الوالدان', 'الدعاء للوالدين',
      'رب ارحمهما كما ربياني صغيرا.',
      'القرآن الكريم: الإسراء 24'),
  Dua('الاستغفار', 'سيد الاستغفار',
      'أستغفر الله العظيم وأتوب إليه.',
      'ذكر الاستغفار'),
  Dua('الرزق', 'دعاء الرزق الحلال',
      'اللهم اكفني بحلالك عن حرامك، وأغنني بفضلك عمن سواك.',
      'سنن الترمذي'),
  Dua('التوبة', 'دعاء التوبة',
      'ربنا ظلمنا أنفسنا وإن لم تغفر لنا وترحمنا لنكونن من الخاسرين.',
      'القرآن الكريم: الأعراف 23'),
  Dua('القرآن', 'دعاء جامع',
      'ربنا آتنا في الدنيا حسنة وفي الآخرة حسنة وقنا عذاب النار.',
      'القرآن الكريم: البقرة 201'),
  Dua('المطر', 'عند نزول المطر',
      'اللهم صيبا نافعا.', 'صحيح البخاري'),
  Dua('الاستغفار', 'التسبيح',
      'سبحان الله وبحمده، سبحان الله العظيم.',
      'صحيح البخاري ومسلم'),
];

class DuaHome extends StatefulWidget {
  const DuaHome({super.key});

  @override
  State<DuaHome> createState() => _DuaHomeState();
}

class _DuaHomeState extends State<DuaHome> {
  String search = '';
  String category = 'الكل';
  final Set<String> favorites = {};

  List<String> get categories =>
      ['الكل', ...duas.map((d) => d.category).toSet()];

  @override
  Widget build(BuildContext context) {
    final items = duas.where((d) {
      final matchesCategory =
          category == 'الكل' || d.category == category;
      final matchesSearch =
          '${d.title} ${d.text} ${d.category}'
              .contains(search.trim());
      return matchesCategory && matchesSearch;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('أدعية المسلم'),
        actions: [
          IconButton(
            tooltip: 'المفضلة',
            icon: const Icon(Icons.favorite),
            onPressed: () => showFavorites(),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: green,
            child: const Column(
              children: [
                Icon(Icons.mosque, color: gold, size: 44),
                SizedBox(height: 8),
                Text('وَاذْكُرُوا اللَّهَ كَثِيرًا',
                    style: TextStyle(
                        color: gold,
                        fontSize: 23,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Text('أدعية وأذكار بين يديك دون إنترنت',
                    style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              textDirection: TextDirection.rtl,
              onChanged: (v) => setState(() => search = v),
              decoration: InputDecoration(
                hintText: 'ابحث عن دعاء...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 48,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: categories.map((c) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: ChoiceChip(
                  label: Text(c),
                  selected: category == c,
                  onSelected: (_) => setState(() => category = c),
                ),
              )).toList(),
            ),
          ),
          Expanded(
            child: items.isEmpty
                ? const Center(child: Text('لا توجد أدعية مطابقة'))
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: items.length,
                    itemBuilder: (context, i) {
                      final d = items[i];
                      final fav = favorites.contains(d.title);
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(d.title,
                                        style: const TextStyle(
                                          color: green,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ),
                                  IconButton(
                                    onPressed: () => setState(() {
                                      fav
                                          ? favorites.remove(d.title)
                                          : favorites.add(d.title);
                                    }),
                                    icon: Icon(
                                      fav ? Icons.favorite : Icons.favorite_border,
                                      color: fav ? Colors.red : green,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(d.text,
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    height: 1.8,
                                  )),
                              const SizedBox(height: 8),
                              Text('المصدر: ${d.source}',
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 12)),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: TextButton.icon(
                                  onPressed: () {
                                    Clipboard.setData(
                                      ClipboardData(text: d.text),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('تم نسخ الدعاء'),
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.copy),
                                  label: const Text('نسخ الدعاء'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void showFavorites() {
    final saved = duas
        .where((d) => favorites.contains(d.title))
        .toList();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * .7,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Text('الأدعية المفضلة',
                    style: TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold)),
                ...saved.map((d) => ListTile(
                      title: Text(d.title),
                      subtitle: Text(d.text),
                    )),
                if (saved.isEmpty)
                  const Text('لم تضف أدعية للمفضلة بعد'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
