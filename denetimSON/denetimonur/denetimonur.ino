

#include <OneWire.h> // OneWire kütüphanesini ekliyoruz.

// Sıcaklık sensörünü bağladığımız dijital pini 2 olarak belirliyoruz.
int DS18S20_Pin = 2; 

// Sıcaklık Sensörü Giriş-Çıkışı
OneWire ds(DS18S20_Pin);  // 2. Dijital pinde.

// Role için 7 numaralı pin belirlenmiştir.
int role = 7;


void setup(void) {
  Serial.begin(9600); // Seri iletişimi başlatıyoruz.
  pinMode(role,OUTPUT);
}

void loop(void) {
  // temperature değişkenini sıcaklık değerini alma fonksiyonuna bağlıyoruz.
  float temperature = getTemp();
  // Sensörden gelen sıcaklık değerini Serial monitörde yazdırıyoruz.
  Serial.print("Sicaklik: ");
  Serial.println(temperature);
  // 1 saniye bekliyoruz. Monitörde saniyede 1 sıcaklık değeri yazmaya devam edecek.
  delay(1000);
  
   if(temperature > 0 && temperature <= 90) // sensörden ölçülen sıcaklık 0 dereceden büyük 90 dereceden küçükse röleyi aktifleştiriyoruz.
  {
    digitalWrite(role,HIGH); // ilgili pin HIGH yapılarak röle aktifleştirildi.
  }
  
  if(temperature >= 60) // suyun sıcaklığı 91 dereceye ulaştığında röleyi 10 saniye daha çalıştırıyoruz.
  {
    digitalWrite(role,HIGH);
    Serial.print("Sicaklik: "); // serial monitörde sıcaklık değeri yazdırılıyor
    Serial.println(temperature);
    Serial.print("Kaynama\n");  // serial monitorde ''kaynama'' yazdırılıyor.
    delay(10000);
    
    digitalWrite(role,LOW);  // belirlenen süre bittiğinde röleyi kapatarak sistemi beklemeye alıyoruz
    Serial.print("Beklemede\n"); // serial monitorde ''beklemede'' yazdırılıyor.
    delay(60000);    
  }
}

// Aşağıdaki fonksiyon DS18B20 sıcaklık sensörümüzden gelen verileri
// Celcius cinsinden sıcaklık değerlerine çevirmek için kullanılıyor.
// Herhangi bir değişiklik yapmamız gerekmiyor.

float getTemp(){
  // suyun sıcaklığını Celcius cinsinden sensörden bu fonksiyonla alıyoruz

  byte data[12];
  byte addr[8];

  if ( !ds.search(addr)) {
      // tek sensör kullanıyoruz bu noktada aramayı resetliyoruz
      ds.reset_search();
      return -1000;
  }

  if ( OneWire::crc8( addr, 7) != addr[7]) {
      Serial.println("CRC is not valid!");
      return -1000;
  }

  if ( addr[0] != 0x10 && addr[0] != 0x28) {
      Serial.print("Device is not recognized");
      return -1000;
  }

  ds.reset();
  ds.select(addr);
  ds.write(0x44,1); // 

  byte present = ds.reset();
  ds.select(addr);    
  ds.write(0xBE); // 

  for (int i = 0; i < 9; i++) { // 9 byte kullanılacak
    data[i] = ds.read();
  }

  ds.reset_search();

  byte MSB = data[1];
  byte LSB = data[0];

  float tempRead = ((MSB << 8) | LSB); // iki komplimentini alıyoruz 
  float TemperatureSum = tempRead / 16;

  return TemperatureSum;

}
