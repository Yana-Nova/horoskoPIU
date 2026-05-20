//библиотека для интерфейса для переменных
import 'package:flutter/material.dart';
//random luck
import 'dart:math';

class User{
  
  
  //final чтобы пароль и аккаунт были одниНННЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕТТТТТТТТТиииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииииитекстттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттттстринггггггггггиггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггггг
  final String password;
  final String login;
 //userrrrrrrrrrrrrrrrrrrrr construktorrrrrrrrrr kotory sozdaet pol'zovatelyarrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr
  User({
  //required чтобы не пыло пустых полейррррррррррррррррррррррррррррррррррррррррррррррррррррррррррррррррррррррррррррррррррррррррррррррррррррррррррррррррррррр
    required this.login,
  required this.password,
});
  
}

// DATA_MODEL
class ZodiacSign {
  final String name;
  final String emoji;

  const ZodiacSign({required this.name, required this.emoji});

  // Override hashCode and == for proper comparison in DropdownButton
  @override
  //sozdayetsya spetsyal'ny kod dlya sravneniya ob'ektov 
  int get hashCode => Object.hash(name, emoji);

  @override
  //etot kod pomogaet ponyat' chto eto kopiya i eto nado zaschityvat'
  
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ZodiacSign &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          emoji == other.emoji;
}

void main() {
  runApp(const AstroApp());
}
//state full widget-ekran umeet menyatsya
class AstroApp extends StatefulWidget {
  const AstroApp({super.key});
//sozdayem sostoyanie dlya ekrana
  @override
  State<AstroApp> createState() => _AstroAppState();
}
//hranit logigu i dannye prilozheniy
class _AstroAppState extends State<AstroApp>{
 //spisok vseh polzovateley
  final List <User> users=[];
  //UsercurrentUser_yest tekushiy polzovatel'
  User? currentUser;

  @override
  //pererisovat' i iznachal'no narisovat' ekran
  Widget build(BuildContext context) {
    //osnova prilozheniya
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      /*
      ========================================
      ЕСЛИ НЕ ВОШЛИ → LOGIN PAGE
      ЕСЛИ ВОШЛИ → ASTRO PAGE
      ========================================
      */

      home: currentUser == null
          ? LoginPage(
         //peredat spisok polzovateley
            users: users,

              /*
              ========================================
              КОГДА ПОЛЬЗОВАТЕЛЬ ВОШЕЛ
              ========================================
              */

              onLogin: (user) {
                setState(() {
          //sohranit polzovatelya
                  currentUser = user;
                });
              },
            )
      //perenapravleniye na ekran    
      : AstroPage(
              user: currentUser!,

              /*
              ========================================
              ВЫХОД ИЗ АККАУНТА
              ========================================
              */

              onLogout: () {
                setState(() {
                  //ObHOB/\EHuE nolb3oBoTE/\R 
                  currentUser = null;
                });
              },
            ),
    );
  }
}

class LoginPage extends StatefulWidget {
  final List<User> users;
  final Function(User) onLogin;
//FANCSHIN UZER-FyHk4uR, ko1da BXOD YspesheH npuHumaeT nol3oBaTela
  const LoginPage({
    super.key,
    required this.users,
    required this.onLogin,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  /*
  ========================================
  КОНТРОЛЛЕРЫ ДЛЯ ПОЛЕЙ ВВОДА
  ========================================
  */
//D/\R noly4eHuR /\0guHa u nopolR
  final TextEditingController loginController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  String errorText = '';

  void login() {
    final login = loginController.text;
    final password = passwordController.text;

    /*
    ========================================
    ПРОВЕРКА ПОЛЬЗОВАТЕЛЕЙ
    ========================================
    */

    for (var user in widget.users) {
      if (
        user.login == login &&
        user.password == password
      ) {
        widget.onLogin(user);
        //OCTAHOBUTb nouck
        return;
      }
    }

    setState(() {
      errorText = 'Неверный логин или пароль';
    });
  }
//void--OTKPblBAEM 3KPAH PEGuCTPACuu
  void openRegisterPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegisterPage(
          users: widget.users,
        ),
      ),
    );
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,

      appBar: AppBar(
        title: const Text('Вход'),
      ),

      body: Center(
        child: Card(
          margin: const EdgeInsets.all(24),

          child: Padding(
            padding: const EdgeInsets.all(24),

            child: Column(
              mainAxisSize: MainAxisSize.min,

              children: [
                const Text(
                  'Авторизация',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                /*
                ========================================
                ПОЛЕ ЛОГИНА
                ========================================
                */

                TextField(
                  controller: loginController,
                  decoration: const InputDecoration(
                    labelText: 'Логин',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 12),

                /*
                ========================================
                ПОЛЕ ПАРОЛЯ
                ========================================
                */

                TextField(
                  controller: passwordController,
                  obscureText: true,
//CKPblTb napolb TO4KAMu
                  decoration: const InputDecoration(
                    labelText: 'Пароль',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  errorText,
                  style: const TextStyle(
                    color: Colors.red,
                  ),
                ),

                const SizedBox(height: 12),

                /*
                ========================================
                КНОПКА ВХОДА
                ========================================
                */

                ElevatedButton(
                  onPressed: login,
                  child: const Text('Войти'),
                ),

                const SizedBox(height: 12),

                /*
                ========================================
                КНОПКА РЕГИСТРАЦИИ
                ========================================
                */

                OutlinedButton(
                  onPressed: openRegisterPage,
                  child: const Text('Регистрация'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RegisterPage extends StatefulWidget {
  final List<User> users;

  const RegisterPage({
    super.key,
    required this.users,
  });

   @override
  State<RegisterPage> createState() =>
      _RegisterPageState();
}

class _RegisterPageState
    extends State<RegisterPage> {

  final TextEditingController loginController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  String infoText = '';

  void register() {
    final login = loginController.text;
    final password = passwordController.text;

    /*
    ========================================
    ПРОВЕРКА НА ПУСТЫЕ ПОЛЯ
    ========================================
    */

    if (login.isEmpty || password.isEmpty) {
      setState(() {
        infoText = 'Заполните поля';
      });

      return;
    }

    /*
    ========================================
    СОЗДАЕМ НОВОГО ПОЛЬЗОВАТЕЛЯ
    ========================================
    */
//B ObWuy CnuCOK nol3oBATE/\EY
    widget.users.add(
      User(
        login: login,
        password: password,
      ),
    );
//ObHOB/\EHuE 3KPAHA
    setState(() {
      infoText = 'Пользователь создан';
    });
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,

      appBar: AppBar(
        title: const Text('Регистрация'),
      ),

      body: Center(
        child: Card(
          margin: const EdgeInsets.all(24),

          child: Padding(
            padding: const EdgeInsets.all(24),

            child: Column(
              mainAxisSize: MainAxisSize.min,

              children: [
                const Text(
                  'Регистрация',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                TextField(
                  controller: loginController,
//BBEDEHHblu /\OGUH nonaDaeT B /\OGIH KOHTPO/\R
                  decoration: const InputDecoration(
                    labelText: 'Логин',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 12),

                TextField(
                  controller: passwordController,
                  obscureText: true,
//ObCKYP  TEKCT nPR4ET napo/\b
                  decoration: const InputDecoration(
                    labelText: 'Пароль',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  infoText,
                  style: const TextStyle(
                    color: Colors.green,
                  ),
                ),

                const SizedBox(height: 12),

                ElevatedButton(
                  onPressed: register,
                  child: const Text('Создать аккаунт'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AstroPage extends StatefulWidget {
  //no/\b3oBATELb KOTOPblu BOWE/\
final User user;
//FYHK4UR BblXODA
  final VoidCallback onLogout;

  const AstroPage({
    super.key,
    required this.user,
    required this.onLogout,
  });
  @override
  State<AstroPage> createState() => _AstroPageState();
}

class _AstroPageState extends State<AstroPage> {
  final Random random = Random();
int luck = 0;
  int clicks = 0;
  String getLuckStatus() {
  if (luck >= 80) {
    return 'Супер удача 🔥';
  } else if (luck >= 50) {
    return 'Нормальный день 😎';
  } else if (luck >= 25) {
    return 'Будь внимательнее 👀';
  } else {
    return 'День для осторожных решений 🧘';
  }
} 
  final List<String>gah=[];
  final List<ZodiacSign> allZodiacSigns = const [
    ZodiacSign(name: 'Овен', emoji: '♈'),
    ZodiacSign(name: 'Телец', emoji: '♉'),
    ZodiacSign(name: 'Близнецы', emoji: '♊'),
    ZodiacSign(name: 'Рак', emoji: '♋'),
    ZodiacSign(name: 'Лев', emoji: '♌'),
    ZodiacSign(name: 'Дева', emoji: '♍'),
    ZodiacSign(name: 'Весы', emoji: '♎'),
    ZodiacSign(name: 'Скорпион', emoji: '♏'),
    ZodiacSign(name: 'Стрелец', emoji: '♐'),
    ZodiacSign(name: 'Козерог', emoji: '♑'),
    ZodiacSign(name: 'Водолей', emoji: '♒'),
    ZodiacSign(name: 'Рыбы', emoji: '♓'),
  ];

  late ZodiacSign _selectedSign;
  String _predictionText;

  _AstroPageState()
      : _selectedSign = const ZodiacSign(name: 'Овен', emoji: '♈'),
        _predictionText = 'Нажми кнопку и получи гороскоп 🔮';

  final List<String> _predictions = const [
    'Сегодня тебя ждёт удача!',
    'Хороший день для новых идей!',
    'Не спеши — сегодня важно подумать.',
    'Будь внимателен к деталям.',
    'Наступает время для решительных действий.',
    'Сегодня возможны приятные сюрпризы.',
    'Слушай свою интуицию.',
    'Новые знакомства принесут пользу.',
    'Посвяти время отдыху и восстановлению.',
    'День благоприятен для завершения начатых дел.',
    'Возможно, стоит пересмотреть свои планы.',
    'Проведи время с близкими.'
  ];
final List<String> Vorpalus=[
  '✨ Секретный прогноз: сегодня ты легенда!',
  '🌌 Вселенная выбрала тебя для особой миссии.',
  '🔥 Редкий прогноз: удача сегодня на максимуме!',

]; 
   void Reset() {
    setState(() {
   
             _selectedSign = const ZodiacSign(name: 'Овен', emoji: '♈');
        _predictionText = 'Нажми кнопку и получи гороскоп 🔮'; luck=0;
      gah.clear();
      clicks=0;});}
  void _getPrediction() {
    setState(() {
      //ФOPMY/\A KOTOPAR nOMOGAET BblBECTU CEKPETHOE COOBWEHUE
      bool Secret=random.nextInt(100)<10;
      
      if(Secret){
          _predictionText = Vorpalus[random.nextInt(Vorpalus.length)];
        
      }else {
        
      
      _predictionText = _predictions[random.nextInt(_predictions.length)];
      }
      luck = random.nextInt(101);
    clicks++;
      //UHCEPT-DObABUTb 3Anucb B HA4ALO CnUCKA UCTOPUU
      gah.insert(0,'${_selectedSign.emoji} ${_selectedSign.name} $_predictionText удача $luck%');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      
      appBar: AppBar(
        title: Text('Привет ${widget.user.login}'),
        //KHOnKA CnPABA B BEPXHEU nAHE/\U
        actions:[
          IconButton(
          onPressed:widget.onLogout,
            icon:Icon(Icons.logout),
          ),
        ],
        centerTitle: true,
      //прокрутка экрана
      ),body: SingleChildScrollView(
      child: Center(
        child: Card(
          margin: const EdgeInsets.all(24),
          child: Padding(
            padding: const EdgeInsets.all(24),
           
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  '${_selectedSign.emoji} Мой гороскоп',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                //cgbcjr МММИИИИИИИИИИИИИИИИИИИИИИПП
                DropdownButton<ZodiacSign>(
                  value: _selectedSign,
                  items: allZodiacSigns
                  //geyrn dsgflf.obv cgbcrt пункт выпадающим списке    
                  .map<DropdownMenuItem<ZodiacSign>>((ZodiacSign signItem) {
                    return DropdownMenuItem<ZodiacSign>(
                      value: signItem,
                      child: Text('${signItem.emoji} ${signItem.name}'),
                    );
                  }).toList(),
                  onChanged: (ZodiacSign? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedSign = newValue;
                      });
                    }
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _getPrediction,
                  child: const Text('Получить гороскоп'),
                ),
                const SizedBox(height: 24),
                Text(
                  _predictionText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 22),
                ), 
                 const SizedBox(height: 4),
                Text(
                  'luck chance today $luck%',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 22),
                ),
                const SizedBox(height: 5),
                Text(
  getLuckStatus(),
  style: const TextStyle(fontSize: 18),
),
            const SizedBox(height:4),
                LinearProgressIndicator(
                value: luck /100,
                ),
                 const SizedBox(height: 4),
                Text(
                  'количество попыток $clicks',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 22),
                ),
                const SizedBox(height: 8),

                  OutlinedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HistPage(history: gah),
                        ),
                      );
                    },
                    icon: const Icon(Icons.history),
                    label: const Text('История'),
                  ),
                const SizedBox(height: 4),
                TextButton(
                onPressed: Reset,
                child: const Text ('Reset'),
                ),
              ],
            ),
          ),
        ),
      ),
   ), );
  }
}
      class HistPage extends StatelessWidget {
  final List<String> history;

  const HistPage({
    super.key,
    required this.history,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('История прогнозов 📜'),
      ),
      body: history.isEmpty
          ? const Center(
              child: Text(
                'История пока пустая',
                style: TextStyle(fontSize: 22),
              ),
            )
          : ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.star),
                  title: Text(history[index]),
                );
              },
            ),
    );
  }
}
