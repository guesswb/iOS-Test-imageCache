# iOS-image

## NSCache
|NSCache|NSCache + 이미지resize|NSCache + 이미지downsmpling|
|---|---|---|
||||
||||
||||
  
## Dictionary  
|순정|메모리캐시|메모리캐시 + 이미지resize|메모리캐시 + 이미지downsmpling|
|:---:|:---:|:---:|:---:|
|<img width="150px" src="https://user-images.githubusercontent.com/54696445/233882238-d438e1a3-cb3a-453e-aaaa-a3a1bb4454a2.gif"/>|<img width="150px" src="https://user-images.githubusercontent.com/54696445/233882485-25485bd9-9457-4346-956a-0c03db915f8b.gif"/>|<img width="150px" src="https://user-images.githubusercontent.com/54696445/233882753-0005a416-e9c8-4bfe-b62b-897860acac42.gif"/>|<img width="150px" src="https://user-images.githubusercontent.com/54696445/233892303-c3a6f0e7-f209-41f0-a85d-66b591b358ab.gif"/>|
|<img width="150px" src="https://user-images.githubusercontent.com/54696445/233882245-4fd3987e-9c38-4068-9896-ae278442c018.png"/>|<img width="150px" src="https://user-images.githubusercontent.com/54696445/233882489-b300d9e7-d9c3-4795-a74d-01daf17dc751.png"/>|<img width="150px" src="https://user-images.githubusercontent.com/54696445/233882762-cd0ad92d-f07e-405b-af05-ff2a16bb223c.png"/>|<img width="150px" src="https://user-images.githubusercontent.com/54696445/233892317-923de516-289c-48ee-8623-1b19536a229d.png"/>|
|스크롤 내릴 때 network 요청<br/>스크롤 올릴 때 network 요청|스크롤 내릴 때 network 요청<br/>스크롤 올릴 때 cache<br/>memory 많이 잡아먹음|스크롤 내릴 때 network요청 -> resize<br/>스크롤 올릴 때 cache<br/>memory 적게 사용|스크롤 내릴 때 network 요청 -> downsampling<br/>스크롤 올릴 때 cache<br/>메모리 적게 사용<br/>decoding에 cpu 적게 사용|
