class TestModel {
  final String resim;
  final String cevapanahtari;
  final String ogrencicevaplar;
  final String cevapdurum;
  final int puan;

  TestModel(this.resim, this.cevapanahtari, this.ogrencicevaplar,
      this.cevapdurum, this.puan);

  TestModel.fromJson(Map<String, dynamic> json)
      : resim = json['resim'],
        cevapanahtari = json['cevapanahtari'],
        ogrencicevaplar = json['ogrencicevaplar'],
        cevapdurum = json['cevapdurum'],
        puan = json['puan'];

  Map<String, dynamic> toJson() => {
        'resim': resim,
        'cevapanahtari': cevapanahtari,
        'ogrencicevaplar': ogrencicevaplar,
        'cevapdurum': cevapdurum,
        'puan': puan
      };
}
