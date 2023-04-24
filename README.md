# iOS-image

## NSCache
|NSCache|NSCache + 이미지resize|NSCache + 이미지downsmpling|
|---|---|---|
||||
||||
||||
  
## Dictionary  
|순정|메모리캐시|메모리캐시 + 이미지resize|메모리캐시 + 이미지downsmpling|
|---|---|---|---|
|<img width="150px" src="https://user-images.githubusercontent.com/54696445/233882238-d438e1a3-cb3a-453e-aaaa-a3a1bb4454a2.gif"/>|<img width="150px" src="https://user-images.githubusercontent.com/54696445/233882485-25485bd9-9457-4346-956a-0c03db915f8b.gif"/>|<img width="150px" src="https://user-images.githubusercontent.com/54696445/233882753-0005a416-e9c8-4bfe-b62b-897860acac42.gif"/>||
|<img width="150px" src="https://user-images.githubusercontent.com/54696445/233882245-4fd3987e-9c38-4068-9896-ae278442c018.png"/><br/><img width="150px" src="https://user-images.githubusercontent.com/54696445/233882247-9735f2ee-ba17-4085-8ea8-1f5f68d0b586.png"/>|<img width="150px" src="https://user-images.githubusercontent.com/54696445/233882489-b300d9e7-d9c3-4795-a74d-01daf17dc751.png"/><br/><img width="150px" src="https://user-images.githubusercontent.com/54696445/233882494-4fcac7f3-287e-466f-9367-56137fe826d5.png"/>|<img width="150px" src="https://user-images.githubusercontent.com/54696445/233882762-cd0ad92d-f07e-405b-af05-ff2a16bb223c.png"/><br/><img width="150px" src="https://user-images.githubusercontent.com/54696445/233882765-7aede3c4-0959-46ee-adc6-2821edbc8e7e.png"/>||
|스크롤 내릴 때 network 요청<br/>스크롤 올릴 때 network 요청|스크롤 내릴 때 network 요청<br/>스크롤 올릴 때 cache<br/>memory 많이 잡아먹음|스크롤 내릴 때 network요청 -> resize<br/>스크롤 올릴 때 cache<br/>memory 적게 사용||
