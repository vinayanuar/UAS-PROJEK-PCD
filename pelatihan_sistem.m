clc; clear; close all;

% membaca file citra dalam folder
image_folder ='data latih';
filename = dir(fullfile(image_folder,   '*.jpg'));
[jumlah_data] = numel(filename);

% menginiliasisasi variabel data_latih
data_latih = zeros(jumlah_data,5);

% proses ekstraksi ciri orde satu
for k = 1:jumlah_data
    full_name = fullfile(image_folder, filenames(k).name);
    Img = imread(full_name);
    Img = rgb2gray(Img);
    H = imhist(Img)';
    H = H/sum(H);
    I = (0:255);
    CiriMEAN = I * H;
    CiriENT = -H * log2(H+eps)';
    CiriVAR = (I-CiriMean).^2*H';
    CiriSKEW = (I-CiriMean).^3*H'/ CiriVAR^1.5;
    CiriKURT = (I-CiriMean).^4*H'/ CiriVAR^2-3;
    data_latih(k,:) = [CiriMEAN,CiriENT,CiriVAR,CiriSKEW,CiriSKURT];
end
% penentuan nilai target untuk masing-maisng jenis bunga
target_latih = zeros(1,jumlah_data);
target_latih(1:6) = 1; %kamboja_biasa
target_latih(7:12) = 2; %kamboja_merah
target_latih(13:18) = 3; %kamboja_plumeriapudica
target_latih(19:24) = 4; %melati-gambir
target_latih(25:30) = 5; %melati_kuning

% pelatihan menggunakan algoritma multivism
output = multivsm(data_latih,target_latih,data_latih);

%menghitung nilai akurasi pelatihan
[n,~] = find(targer_latihan==output');
jumlah_benar = sum(n);
akurasi = jumlah_benar/jumlah_data*100;

% menyimpan variabel data_latih dan target_latih
save data_latih data_latih
save target_latih target_latih