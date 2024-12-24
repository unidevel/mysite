# Ollama

---

## 在AMD 780m GPU上运行ollama ( Arch linux )

必要条件:
1. GPU是780m的AMD CPU比如AMD Ryzen™ 7 8845HS
2. 在Bios中设置指定GPU的显存比如16G，(8G左右可以运行8b的模型, 16G可以运行11-14b的模型)

步骤:

1. 安装`ollama`和`ollama-rocm`
```
pacman -S ollama ollama-rocm
```

2. 设置相关的环境变量
```
set -gx HSA_OVERRIDE_GFX_VERSION "11.0.2"
# set -gx OLLAMA_LLM_LIBRARY rocm_v60000u
set -gx OLLAMA_LLM_LIBRARY rocm_v60000u_avx512
```

3. 测试
```
ollama serve

ollama run tinyllama --verbose
```

4. 验证模型在GPU内存中加载
```
ollama run tinyllama
ollama ps

NAME                ID              SIZE      PROCESSOR    UNTIL
tinyllama:latest    2644915ede35    1.9 GB    100% GPU     4 minutes from now
```

模型如果大于GPU的容量，会首先在GPU内存中加载，剩下的在普通内存中加载，比如这个`gemma2:27b`
```
ollama run gemma2:27b
ollama ps

NAME          ID              SIZE     PROCESSOR          UNTIL
gemma2:27b    53261bc9c192    18 GB    12%/88% CPU/GPU    3 minutes from now
```

5. 比较，可以看出GPU的速度快那么一点儿

a. 使用GPU运行
```
$ for run in {1..10}; do echo "where was beethoven born?" | ollama run tinyllama --verbose 2>&1 >/dev/null | grep "eval rate:"; done
prompt eval rate:     1354.84 tokens/s
eval rate:            88.77 tokens/s
prompt eval rate:     14000.00 tokens/s
eval rate:            95.31 tokens/s
prompt eval rate:     21000.00 tokens/s
eval rate:            98.04 tokens/s
prompt eval rate:     14000.00 tokens/s
eval rate:            97.29 tokens/s
prompt eval rate:     10500.00 tokens/s
eval rate:            96.05 tokens/s
prompt eval rate:     14000.00 tokens/s
eval rate:            98.02 tokens/s
prompt eval rate:     10500.00 tokens/s
eval rate:            98.49 tokens/s
prompt eval rate:     21000.00 tokens/s
eval rate:            100.00 tokens/s
prompt eval rate:     14000.00 tokens/s
eval rate:            97.64 tokens/s
prompt eval rate:     14000.00 tokens/s
```

b. 使用CPU运行(清理环境变量，重新运行`ollama serve`)
```
$ for run in {1..10}; do echo "where was beethoven born?" | ollama run tinyllama --verbose 2>&1 >/dev/null | grep "eval rate:"; done
prompt eval rate:     283.78 tokens/s
eval rate:            83.72 tokens/s
prompt eval rate:     2625.00 tokens/s
eval rate:            83.53 tokens/s
prompt eval rate:     2625.00 tokens/s
eval rate:            63.49 tokens/s
prompt eval rate:     2625.00 tokens/s
eval rate:            85.50 tokens/s
prompt eval rate:     2800.00 tokens/s
eval rate:            88.00 tokens/s
prompt eval rate:     3000.00 tokens/s
eval rate:            81.51 tokens/s
prompt eval rate:     3000.00 tokens/s
eval rate:            80.80 tokens/s
prompt eval rate:     2625.00 tokens/s
eval rate:            79.26 tokens/s
prompt eval rate:     2800.00 tokens/s
eval rate:            81.08 tokens/s
prompt eval rate:     2800.00 tokens/s
eval rate:            85.82 tokens/s
```
