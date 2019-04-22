# 폴더 설명

## - 폴더 구조
```
├── README.md                   # 현재 파일
├── docker-images               # LGH AML용 Dockrfile들
│   ├── ngc                     # NVIDIA NGC GPU 버전
│   │   ├── CUDA                # CUDA 버전
│   │   │   └── Dockerfile
│   │   └── Tensorflow          # Tensorflow 버전
│   │       └── Dockerfile
│   └── no-gpu                  # Tensorflow CPU 버전
│       └── Dockerfile
└── kubeflow
```