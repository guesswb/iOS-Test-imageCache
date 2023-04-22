# iOS-image

|순정|메모리캐시|메모리캐시 + 이미지resize|메모리캐시 + 이미지downsmpling|메모리캐시 + 이미지downsampling + 디스크캐시|
|---|---|---|---|---|
|<img width="150px" src="https://user-images.githubusercontent.com/54696445/233754099-28984efa-d7a9-40a3-8c71-2211700e67b4.gif"/>|<img width="150px" src="https://user-images.githubusercontent.com/54696445/233754177-84f76e1d-9d1a-471f-8d0d-e57f4838206c.gif"/>||||
|<img width="150px" src="https://user-images.githubusercontent.com/54696445/233754102-f0896561-9d92-4bdf-95fc-1dcedcdcea88.png"/>|<img width="150px" src="https://user-images.githubusercontent.com/54696445/233754178-c44651a9-b42b-4ab6-89f9-6ee37bbfeb8d.png"/>||||
|스크롤 내릴 때 network 요청<br/>스크롤 올릴 때 network 요청|스크롤 내릴 때 network 요청<br/>스크롤 올릴 때 cache<br/>memory 많이 잡아먹음||||
