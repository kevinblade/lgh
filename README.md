# AML ML Docker 개바환경

## - 폴더 구조
```
├── README.md                   # 현재 파일
├── docker-images                 # LGH AML용 Dockrfile들
│   ├── ngc                         # NVIDIA NGC GPU 버전
│   │   ├── CUDA                      # CUDA 버전 (제외된 버전이지만 참고용.)
│   │   │   └── Dockerfile
│   │   └── Tensorflow                # Tensorflow 버전 (배포예정 버전)
│   │       └── Dockerfile
│   └── no-gpu                      # CPU 버전 (테스트 목적)
│       └── Dockerfile                # Tensorflow + Jupyter + JupyterLab + Airflow, Scikit-learn, Pandas, DVC 등 설치
└── kubeflow
```

## - no-gpu/Dockerfile 빌드
```
$ docker build -t lgh-aml-container:no-gpu .                    # Dockerfile이 존재하는 폴더에서 실행.
$ docker image prune --force                                    # 기존에 빌드한 이미지 중 사용이 안되는 것들을 삭제.
```

## - lgh-aml-container:no-gpu 실행 후 JupyterLab 사용하기
```
$ docker run --rm -it -d -p 9200:8888 lgh-aml-container:no-gpu  # -d 옵션으로 인해 데몬으로 실행, 실행 로그를 보기 원하면 -d 옵션 제거.
# 내 로컬 브라우저에서 http://211.170.240.54:9200 로 접근.
# 암호 설정을 컨테이너 실행시 root로 설정되어 있음. 암호입력창에 root를 입력하면 JupyterLab 홈화면으로 이동.
```
