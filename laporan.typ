#import "@preview/charged-ieee:0.1.4": ieee

#show: ieee.with(
  title: [Analisis dan Pemodelan Deret Waktu pada Data Tourist Visitors Menggunakan Metode SARIMA],
  abstract: [
    Tourism demand forecasting is a critical component for strategic planning in the hospitality industry. However, tourism data is typically characterized by strong seasonality, trends, and non-stationarity, making accurate prediction challenging. This study aims to analyze the univariate time series characteristics of tourist visitor numbers using the SARIMA (Seasonal Autoregressive Integrated Moving Average) methodology. The process involves data description, visualization, stationarity testing using the Augmented Dickey-Fuller (ADF) test, and data transformation via differencing. The study further identifies the tentative model orders for both non-seasonal ($p, d, q$) and seasonal ($P, D, Q$) components through ACF and PACF plots. The results demonstrate that the raw data requires differencing to satisfy the stationarity assumptions necessary for robust modeling.
  ],
  authors: (
    (
      name: "Muhammad Karov Ardava Barus",
      department: [School of Computing],
      organization: [Telkom University],
      location: [Bandung, Indonesia],
      email: "barusardava@student.telkomuniversity.ac.id"
    ),
    (
      name: "Muhammad Al Fayedhh Denof",
      department: [School of Computing],
      organization: [Telkom University],
      location: [Bandung, Indonesia],
      email: "alfayyedhh@student.telkomuniversity.ac.id"
    ),
    (
      name: "Stephani Maria Sianturi",
      department: [School of Computing],
      organization: [Telkom University],
      location: [Bandung, Indonesia],
      email: "stephanims@student.telkomuniversity.ac.id"
    ),
    (
      name: "Hilda Fahlena",
      department: [School of Computing],
      organization: [Telkom University],
      location: [Bandung, Indonesia],
      email: "hildafahlena@telkomuniversity.ac.id"
    ),
  ),
  index-terms: ("Time Series Analysis", "Tourism Forecasting", "SARIMA", "Stationarity", "ADF Test"),
  // PENTING: Pastikan file 'refs.bib' sudah dibuat di panel kiri dan berisi daftar pustaka.
  bibliography: bibliography("refs.bib"),
  figure-supplement: [Fig.],
)

= PENDAHULUAN
Sektor pariwisata merupakan salah satu industri yang paling dinamis dan berkontribusi signifikan terhadap perekonomian, namun sangat sensitif terhadap faktor eksternal dan pola musiman. Kemampuan untuk memprediksi jumlah kunjungan wisatawan (*tourist numbers*) secara akurat memungkinkan pemangku kepentingan untuk mengoptimalkan manajemen kapasitas dan strategi pemasaran @song2008tourism. Namun, data pariwisata seringkali menunjukkan pola yang kompleks, yaitu adanya tren jangka panjang yang bercampur dengan fluktuasi musiman yang kuat.

== Latar Belakang
Metode peramalan klasik seringkali gagal menangkap dinamika data yang memiliki pola musiman stokastik. Penggunaan metode regresi standar pada data deret waktu yang tidak stasioner dapat menghasilkan "regresi palsu" (*spurious regression*), di mana model tampak memiliki performa statistik yang baik namun gagal dalam melakukan prediksi masa depan @hyndman2018forecasting. Oleh karena itu, pendekatan *Seasonal Autoregressive Integrated Moving Average* (SARIMA) dipilih karena kemampuannya memodelkan korelasi antar waktu dan pola musiman secara simultan. Langkah awal yang krusial dalam pemodelan ini adalah memastikan data memenuhi asumsi kestasioneran melalui serangkaian uji statistik dan transformasi.

== Tinjauan Pustaka
Model SARIMA merupakan perluasan dari model ARIMA yang dikembangkan oleh Box dan Jenkins, dengan penambahan komponen musiman untuk menangani data yang berulang pada interval tertentu (misalnya bulanan atau tahunan) @box2015time. Penelitian Goh dan Law @goh2002modeling menunjukkan bahwa dalam konteks pariwisata, akurasi peramalan sangat bergantung pada penanganan akar unit (*unit root*) dan identifikasi orde model yang tepat melalui plot *Autocorrelation Function* (ACF) dan *Partial Autocorrelation Function* (PACF). Uji *Augmented Dickey-Fuller* (ADF) menjadi standar untuk memvalidasi kestasioneran data sebelum pemodelan dilakukan @dickey1979distribution.



== Tujuan Penelitian
Penelitian ini bertujuan untuk melakukan analisis eksploratif dan identifikasi model awal pada dataset "Tourist Numbers". Mengacu pada instruksi Tugas Besar, tahapan spesifik yang dilakukan adalah:
1.  Mendeskripsikan data yang digunakan.
2.  Melakukan visualisasi (*plotting*) data original.
3.  Memeriksa kestasioneran data menggunakan Uji ADF.
4.  Melakukan proses *differencing* ($d$) jika data tidak stasioner.
5.  Mengidentifikasi orde model SARIMA melalui plot ACF dan PACF.

= METODOLOGI PENELITIAN <sec:methods>
Data yang digunakan dalam penelitian ini adalah data sekunder "Tourist Numbers Univariate Forecasting Dataset". Pengolahan data dilakukan menggunakan *Google Colab* dengan bahasa pemrograman Python, memanfaatkan pustaka `pandas` untuk manajemen data dan `statsmodels` untuk analisis statistik.

Proses analisis dilakukan melalui langkah-langkah berikut:
1.  *Analisis Deskriptif:* Melihat struktur data, rentang waktu, dan statistik dasar.
2.  *Uji Stasioneritas:* Menggunakan uji ADF dengan hipotesis:
    - $H_0$: Data tidak stasioner (memiliki *unit root*).
    - $H_1$: Data stasioner.
    Kriteria keputusan adalah jika nilai $p$-value $< 0.05$, maka tolak $H_0$.
3.  *Transformasi Data:* Jika data mengandung tren atau musiman, dilakukan *differencing* non-musiman ($d$) atau *differencing* musiman ($D$).
  $nabla^d nabla_s^D Y_t$
    Dimana $s$ adalah periode musiman.
4.  *Identifikasi Model:* Mengamati pola *cut-off* atau *tail-off* pada plot ACF dan PACF dari data yang telah stasioner untuk menentukan orde $(p,d,q)(P,D,Q)_s$.
5.  *Pemodelan dan Evaluasi:* Memilih parameter SARIMA menggunakan kriteria informasi (AIC) melalui *grid search* pada data latih, lalu mengevaluasi hasil peramalan pada data uji menggunakan MAE, RMSE, dan MAPE.

= HASIL DAN PEMBAHASAN

== Deskripsi Data
Dataset terdiri dari dua variabel utama: `Date` sebagai indeks waktu dan `TouristNumber` yang merepresentasikan jumlah pengunjung. Data ini merupakan data deret waktu univariat yang diambil dalam periode waktu pengamatan selama 24 tahun, dimulai dari Januari 2000 hingga Desember 2023, dengan total 288 observasi ($N=288$). Frekuensi data adalah bulanan (*monthly*), yang memungkinkan analisis pola musiman tahunan. Data mentah menunjukkan adanya variasi nilai yang signifikan antar periode, yang mengindikasikan adanya dinamika tren dan musiman.

== Plot Data Original
Visualisasi data mentah ditampilkan pada @fig:plot_data.

// Ganti "original_plot.png" dengan nama file gambar Anda yang sudah diupload ke panel kiri
#figure(
  image("image1.png", width: 100%), 
  caption: [Plot Data Original Jumlah Turis]
) <fig:plot_data>

Berdasarkan @fig:plot_data, data menunjukkan perilaku dinamis berupa *tren positif* jangka panjang (*upward trend*) dan *pola musiman* yang berulang secara periodik. Selain itu, terlihat indikasi heteroscedasticity, di mana varians data semakin melebar seiring berjalannya waktu. Kombinasi karakteristik ini mengonfirmasi bahwa data bersifat *tidak stasioner* (baik dalam rata-rata maupun varians), sehingga mutlak memerlukan transformasi seperti *differencing* sebelum dapat dimodelkan.

== Uji Stasioner Variansi (Box-Cox)
Selain stasioner dalam rata-rata, deret waktu juga idealnya memiliki variansi yang relatif konstan. Untuk menangani indikasi heteroscedasticity pada data original, digunakan transformasi Box-Cox untuk menstabilkan variansi.

Secara umum, transformasi Box-Cox didefinisikan sebagai:
$ 
y^(lambda) :=
cases(
  (y^(lambda) - 1) / lambda  & lambda != 0,
  log(y)                     & lambda = 0,
)
$

Parameter $lambda$ diestimasi menggunakan metode *maximum likelihood estimation* (MLE). Hasil estimasi pada data ini adalah:
- *Box-Cox lambda (MLE):* -0.081342
- *Shift applied:* 0.000000 (data sudah bernilai positif, sehingga tidak perlu penyesuaian)

Gambar @fig:boxcox memperlihatkan perbandingan data original vs data hasil transformasi Box-Cox, serta perbandingan *rolling standard deviation* (window=12). Setelah transformasi, variansi relatif lebih stabil dibandingkan data original.

// Gambar ini adalah output uji stabilisasi variansi (Box-Cox) dari notebook
#figure(
  image("boxcox-transform.png", width: 100%),
  caption: [Pemeriksaan Stabilitas Variansi: Data Original vs Transformasi Box-Cox (termasuk *rolling standard deviation*)]
) <fig:boxcox>

== Uji Kestasioneran (ADF Test)
Untuk membuktikan asumsi visual di atas, dilakukan uji statistik ADF. Hasil pengujian pada data level (original) adalah sebagai berikut:

- *ADF Statistic:* 1.247470
- *p-value:* 0.996298

Karena nilai $p$-value $> 0.05$, maka kita menerima $H_0$. Artinya, data original memiliki akar unit dan dinyatakan *tidak stasioner*. Oleh karena itu, data belum siap untuk dimodelkan langsung dan memerlukan proses *differencing*.

== Proses Differencing
Karena data mengandung ketidakstasioneran, dilakukan proses *differencing*. Mengingat adanya pola tren, dilakukan *first differencing* ($d=1$).

Hasil plot setelah *differencing* dapat dilihat pada @fig:plot_diff.

#figure(
  image("image2.png", width: 100%),
  caption: [Plot Data Setelah Proses Differencing (d=1)]
) <fig:plot_diff>

Uji ADF dilakukan kembali pada data hasil *differencing*:
- *ADF Statistic (setelah diff):* -8.170180
- *p-value (setelah diff):* 0.000000000000867

Dengan $p$-value $< 0.05$, data hasil *differencing* kini dinyatakan *stasioner* dan siap untuk tahap identifikasi model.

== Identifikasi Plot ACF dan PACF
Identifikasi orde model SARIMA dilakukan dengan melihat plot ACF dan PACF dari data yang sudah stasioner.

#figure(
  image("image3.png", width: 100%),
  caption: [Plot ACF dan PACF Data Tourist Visitors Setelah Differencing Orde-1 ($d=1$)]
) <fig:acf_pacf>

Analisis plot @fig:acf_pacf:
1.  *Komponen musiman:* Plot ACF menunjukkan lonjakan (spike) kuat pada *lag* ke-12 (dan sekitar), yang mengindikasikan adanya pola musiman tahunan pada data bulanan. Karena itu periode musiman ditetapkan $s=12$ dan model musiman (SARIMA) lebih sesuai dibanding ARIMA non-musiman.
2.  *Komponen non-musiman:* Pada lag rendah, pola ACF/PACF mengindikasikan orde AR/MA yang relatif kecil, sehingga kandidat $p$ dan $q$ dicari pada rentang kecil.

Berdasarkan pola tersebut, kandidat model yang digunakan adalah $(p,1,q)(P,1,Q)_{12}$, lalu dipilih kombinasi terbaik dengan kriteria AIC pada data latih.

== Pemodelan SARIMA dan Evaluasi
Tahap ini melanjutkan identifikasi ACF/PACF dengan pemodelan Seasonal ARIMA (SARIMA).

=== Pembagian Data
Data dibagi menjadi:
- *Data latih:* Januari 2000 s.d. Desember 2022 ($n=276$)
- *Data uji:* Januari 2023 s.d. Desember 2023 ($n=12$)

=== Pemilihan Parameter (Grid Search AIC)
Parameter dicari dengan grid search kecil pada kandidat:
- $p \in \{0,1,2\}$, $q \in \{0,1,2\}$, dengan $d=1$
- $P \in \{0,1\}$, $Q \in \{0,1\}$, dengan $D=1$ dan $s=12$

Kombinasi terbaik (AIC minimum) yang diperoleh adalah:
- *SARIMA $(1,1,2)(0,1,1)_{12}$*

Untuk menunjukkan transparansi pemilihan parameter, @tbl:aic menampilkan 10 kandidat terbaik berdasarkan AIC (semakin kecil semakin baik).

// Tabel ini diambil dari hasil grid search AIC pada notebook (top 10 kandidat)
#figure(
  kind: table,
  caption: [10 kandidat terbaik berdasarkan AIC dari proses *grid search*],
  table(
    columns: 3,
    [*order*], [*seasonal_order*], [*AIC*],
    [(1, 1, 2)], [(0, 1, 1, 12)], [4823.384],
    [(0, 1, 2)], [(0, 1, 1, 12)], [4824.768],
    [(1, 1, 2)], [(1, 1, 1, 12)], [4824.986],
    [(2, 1, 2)], [(0, 1, 1, 12)], [4825.331],
    [(0, 1, 2)], [(1, 1, 1, 12)], [4825.433],
    [(2, 1, 2)], [(1, 1, 1, 12)], [4825.510],
    [(1, 1, 1)], [(0, 1, 1, 12)], [4846.501],
    [(1, 1, 1)], [(1, 1, 1, 12)], [4847.774],
    [(2, 1, 1)], [(0, 1, 1, 12)], [4848.281],
    [(2, 1, 1)], [(1, 1, 1, 12)], [4849.551],
  )
) <tbl:aic>

=== Evaluasi Peramalan
Evaluasi dilakukan pada periode data uji (12 bulan) menggunakan metrik galat:
- *MAE:* 6,433.545
- *RMSE:* 8,887.347
- *MAPE:* 12.23\%

// Gambar ini adalah output plot forecast pada periode test dari notebook
#figure(
  image("sarima-forecast.png", width: 100%),
  caption: [Hasil Peramalan SARIMA pada Periode Uji (Test Period) beserta *confidence interval*]
) <fig:sarima_test>

Selain plot hasil peramalan pada periode uji, dilakukan pemeriksaan diagnostik untuk mengevaluasi karakteristik residual, termasuk pola residual terstandarisasi, histogram dan estimasi densitas, Q-Q plot, serta correlogram. Hasil diagnostik residual ditunjukkan pada @fig:diagnostic.

// Gambar ini adalah output plot diagnostics residual dari notebook
#figure(
  image("diagnostic-plot.png", width: 100%),
  caption: [Plot Diagnostik Residual Model SARIMA]
) <fig:diagnostic>

Terakhir, dilakukan peramalan ke depan untuk memperoleh proyeksi jumlah pengunjung wisatawan pada 12 bulan setelah akhir data. Visualisasi hasil peramalan 12 bulan ke depan ditunjukkan pada @fig:sarima_future.

// Gambar ini adalah output forecast 12 bulan ke depan dari notebook
#figure(
  image("sarima-forecast-12.png", width: 100%),
  caption: [Peramalan 12 Bulan ke Depan Menggunakan Model SARIMA]
) <fig:sarima_future>

= KESIMPULAN
Berdasarkan analisis yang telah dilakukan, dapat disimpulkan bahwa:
1.  Data "Tourist Numbers" memiliki karakteristik tren dan musiman yang kuat.
2.  Uji ADF membuktikan data original tidak stasioner ($p$-value $> 0.05$).
3.  Proses differencing berhasil menstasionerkan data, sehingga memenuhi syarat pemodelan deret waktu.
4.  Identifikasi plot ACF dan PACF menunjukkan adanya musiman tahunan ($s=12$) sehingga pendekatan SARIMA relevan.
5.  Berdasarkan pemilihan parameter menggunakan AIC pada data latih, model terbaik adalah SARIMA $(1,1,2)(0,1,1)_{12}$ dengan performa pada data uji MAPE 12.23\%.