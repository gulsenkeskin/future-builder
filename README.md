# future_builder
 
 <img src='gif/1.gif'  width="340" height="680">
 
Flutter'daki FutureBuilder widget'ına bir göz atacağız. Başlamadan önce, bir adım geriye gidelim ve Flutter'da Futures'ın ne olduğunu ve asenkron programlama ile nasıl çalışılacağını anlayalım.

## Asenkron Programlama

En temel biçiminde, asenkron bir method, programınızın başka bir işlemin tamamlanmasını beklerken yürütülmeye devam etmesine izin verir. Bu, bir işlem tamamlanana kadar diğer işlemlerin yürütülmesinin engellediği senkron (eşzamanlı) programlamadan farklıdır. 

Bunlara örnekler:

⭐ Bir ağ üzerinden veri alma (sonsuz kaydırmayı düşünün)
💫 Database işlemleri
⭐ Dosya I/O işlemleri


Daha önce JavaScript ile çalıştıysanız, [Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise) kavramına aşinasınızdır. Dart'ta Future sınıfına sahibiz ve async ve await anahtar kelimelerini kullanıyoruz. ECMAScript 2017 ile, async/await kalıbı JavaScript ve C# gibi diğer programlama dillerinde de mevcuttur.


Bu yazıda, basit bir kişi listesi uygulaması yapacağız ve bir listeyi asenkron olarak yüklemek için FutureBuilder kullanımını simüle edeceğiz.


## Bölüm 1
FutureBuilders'ın nasıl kullanılacağına geçmeden önce, modelimizi, UI'mizi oluşturma ve bazı yapay veriler oluşturma gibi görevleri tamamlamamız gerekir.


## Model

Başlangıç olarak Contact modelimizi tanımlayalım. Basit tutmak birkaç veri alacağız.


```
class Contact {
  final String? firstName;
  final String? lastName;
  final String? imageUrl;
  final String? phone;

  Contact({
     this.firstName,
     this.lastName,
     this.imageUrl,
     this.phone,
  });
}
```

## Contact Card

Bunu yaptıktan sonra, kişi kartımız için bir UI oluşturalım:


```
import 'package:flutter/material.dart';
import 'models/contact.dart';

class ContactCard extends StatelessWidget {
  final Contact? contact;
  const ContactCard({Key? key, this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 10, right: 15, bottom: 10),
            child: ClipOval(
              child: Image.network(
                contact!.imageUrl!,
                width: 50,
                height: 50,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${contact!.firstName} ${contact!.lastName}'),
                const SizedBox(height: 2),
                Text('${contact!.phone}'),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.create,
                color: Colors.grey[600],
              ),
              const SizedBox(width: 15.0),
              Icon(
                Icons.message,
                color: Colors.grey[600],
              ),
              const SizedBox(width: 15.0),
              Icon(
                Icons.call,
                color: Colors.grey[600],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

```

## Dummy Data

Sahte veriler için, dummy-data.dart dosyasını oluşturuyoruz. Artık veri oluşturma ve kullanıcı arayüzünün bir parçası ile ilgili ikincil görevleri tamamladığımıza göre, şimdi elimizdeki ana göreve, kişilerimizi görüntüleyen ListView'i oluşturmaya geçelim.


```
import 'package:future_builder/model/contact.dart';

List<Contact> dummyData = [
  Contact(
    firstName: 'Bryan',
    lastName: 'Adams',
    imageUrl: 'https://picsum.photos/id/1005/100',
    phone: '+91 98120 43912',
  ),
  Contact(
    firstName: 'Julia',
    lastName: 'Roberts',
    imageUrl: 'https://picsum.photos/id/1012/100',
    phone: '+91 78230 21385',
  ),
  Contact(
    firstName: 'Samantha',
    lastName: 'Drisco',
    imageUrl: 'https://picsum.photos/id/1011/100',
    phone: '+91 89067 24129',
  ),
  Contact(
    firstName: 'Sean',
    lastName: 'Connery',
    imageUrl: 'https://picsum.photos/id/1066/100',
    phone: '+91 92143 79785',
  ),
  Contact(
    firstName: 'Brad',
    lastName: 'Pitt',
    imageUrl: 'https://picsum.photos/id/1074/100',
    phone: '+91 78941 35361',
  ),
  Contact(
    firstName: 'Joe',
    lastName: 'Rogan',
    imageUrl: 'https://picsum.photos/id/177/100',
    phone: '+91 93124 87877',
  ),
  Contact(
    firstName: 'Jennifer',
    lastName: 'Lawrence',
    imageUrl: 'https://picsum.photos/id/203/100',
    phone: '+91 71324 57585',
  ),
  Contact(
    firstName: 'Margot',
    lastName: 'Robbie',
    imageUrl: 'https://picsum.photos/id/22/100',
    phone: '+91 73414 79879',
  ),
  Contact(
    firstName: 'Al',
    lastName: 'Pacino',
    imageUrl: 'https://picsum.photos/id/219/100',
    phone: '+91 96769 34313',
  ),
  Contact(
    firstName: 'Marilyn',
    lastName: 'Monroe',
    imageUrl: 'https://picsum.photos/id/171/100',
    phone: '+91 84534 74646',
  ),
  Contact(
    firstName: 'Corey',
    lastName: 'Taylor',
    imageUrl: 'https://picsum.photos/id/158/100',
    phone: '+91 98784 13213',
  ),
  Contact(
    firstName: 'Seth',
    lastName: 'Rogen',
    imageUrl: 'https://picsum.photos/id/145/100',
    phone: '+91 73138 43541',
  ),
  Contact(
    firstName: 'Tyler',
    lastName: 'Perry',
    imageUrl: 'https://picsum.photos/id/1027/100',
    phone: '+91 83131 48648',
  ),
  Contact(
    firstName: 'Matt',
    lastName: 'Damon',
    imageUrl: 'https://picsum.photos/id/1025/100',
    phone: '+91 78285 31338',
  ),
  Contact(
    firstName: 'John',
    lastName: 'Cena',
    imageUrl: 'https://picsum.photos/id/1/100',
    phone: '+91 80246 48432',
  ),
];
```

## Bölüm 2

Artık contact verilerimizi alacak future'ı tanımlayabiliriz.


```
  Future<List<Contact>>? _contacts;

  Future<List<Contact>> _getContacts() async {
    List<Contact> contacts = dummyData;
    await Future.delayed(Duration(seconds: 10));
    return Future.value(contacts);
  }
```


Kişilerimizi daha önce tanımladığımız dummy data'dan alıyoruz. Sonraki satırda Future.delayed() yöntemini kullandığımı göreceksiniz. Bu yöntem, tanımlı bir süre boyunca kod yürütmeyi askıya almak için kullanılabilir ve bir sunucudan veri alırken normalde gözlemlenecek olan bir arabelleği simüle etmemize yardımcı olur. Gecikme değeri (delay value) tamamlandığında, Future.value() yöntemini kullanarak kişi listesini döndürürüz.

Bundan sonra yapacağımız şey, az önce tanımladığımız future'ı tutacak bir değişken tanımlamaktır.

`Future<List<Contact>>? _contacts;`

_getContacts() ile future'ı initState() içindeki _contacts değişkenine atadık.


```
@override
void initState() {
  super.initState();
  _contacts = _getContacts();
}
```

Bunu neden böyle yaptığımızı merak ediyor olmalısınız. Başka bir değişken eklemek yerine doğrudan FutureBuilder'a _getContacts()'ı  atayamaz mıydık?


Flutter belgelerini gözden geçirirseniz, build method'unun herhangi bir zamanda çağrılabileceğini fark edeceksiniz. Buna setState() veya cihaz oryantasyon değişikliği dahildir. Bunun anlamı, cihaz yapılandırmasındaki veya widget yeniden oluşturmalarındaki herhangi bir değişikliğin Future'ınızı bir çok kez tetiklemesidir. Bunu önlemek için, Feture'ın build() yönteminin kendisinde değil initState() içinde elde edildiğinden emin oluruz. Bu, Future yöntemini doğrudan FutureBuilder'a atayan çevrimiçi birçok öğreticide fark edebileceğiniz bir şeydir ve aslında yanlıştır.

Artık bunu hallettiğimize göre, şimdi build() method'una bir göz atalım :



```
@override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Contact>>(
      future: _contacts,
      builder: (ctx, snapshot) {
        List<Contact>? contacts = snapshot.data;
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return _buildListView(contacts!);
          default:
            return _buildLoadingScreen();
        }
      },
    );
  }

  Widget _buildListView(List<Contact> contacts) {
    return ListView.builder(
      itemBuilder: (ctx, idx) {
        return ContactCard(
          contact: contacts[idx],
        );
      },
      itemCount: contacts.length,
    );
  }

  Widget _buildLoadingScreen() {
    return Center(
      child: Container(
        width: 50,
        height: 50,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
```


FutureBuilder() 'ımızı bir List<Contact> türü ile tanımlıyoruz. Bu gerekli olmasa da, oluşturucu yöntemimizde tür çıkarımına yardımcı olur. _contacts future'ını FutureBuilder'a veriyoruz .


FutureBuilders'ın bir avantajı da, bize sunulan ConnectionState enum'ına sahip olmamızdır. Anlık görüntümüzün connection state'ine bağlı olarak, loading ekranı veya hata ekranı gibi farklı widget'lar gösterebiliriz.

Temelde bizim için uygun 4 durumumuz var.


1. none, bazı initial datalarda.
2. waiting, asenkron (zaman uyumsuz) işlemin başladığını gösterir, genellikle veriler boştur.
3. active , veriler boş değildir ve zamanla değişebilir.
4. done , veriler boş değildir.

Artık tüm parçalarımızı yerleştirdiğimize göre, uygulamamızın nasıl göründüğüne [bir göz atalım](https://github.com/gulsenkeskin/future_builder/blob/main/README.md):

Başlangıçta 10 saniye boyunca görülebilen bir yükleme ekranımız var ve ardından bunun yerini ListView.builder() alıyor. Farklı bağlantı durumlarına göre ek ekranlarımız olabilir, ancak basitlik için 2 ekrana bağlı kalacağız.

Zaman uyumsuz programlamanın nasıl çalıştığına baktık ve FutureBuilder yönteminin nasıl çalıştığını göstermek için basit bir kişi uygulaması tasarladık ve oluşturduk. Ayrıca Future'ı neden build yönteminde değil de initState() içinde elde etmemiz gerektiğine baktık. Ve son olarak, oluşturucumuzda ConnectionState enumlarının nasıl kullanılacağını gördük.


References: 

https://blog.devgenius.io/understanding-futurebuilder-in-flutter-491501526373
https://api.flutter.dev/flutter/widgets/FutureBuilder/future.html
https://api.flutter.dev/flutter/widgets/FutureBuilder-class.html


