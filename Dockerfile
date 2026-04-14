FROM vllm/vllm-openai:nightly

RUN apt-get update && apt-get install -y --no-install-recommends git \
 && rm -rf /var/lib/apt/lists/*

RUN pip uninstall -y transformers || true \
 && pip install -U git+https://github.com/huggingface/transformers.git

ENV HF_HOME=/root/.cache/huggingface
RUN python3 -c "from huggingface_hub import snapshot_download; snapshot_download('zai-org/GLM-OCR')"

EXPOSE 8000

CMD ["--model", "zai-org/GLM-OCR", "--allowed-local-media-path", "/", "--port", "8000"]
