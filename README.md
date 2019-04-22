# 폴더 설명

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

## no-gpu/Dockerfile 빌드
```
$ docker build -t lgh-aml-container:no-gpu .
```

## lgh-aml-container:no-gpu 실행
```
$ docker run --rm -it lgh-aml-container:no-gpu
# 브라우저에서 http://211.170.240.54:8888/?token=ef10b995810b7c1deb28e0c13dad2a1f762677bd5748739a 로 접근.
```
