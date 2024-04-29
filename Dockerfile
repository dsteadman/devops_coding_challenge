FROM public.ecr.aws/lambda/python:3.12

COPY ./{data,dist}/* ${LAMBDA_TASK_ROOT}

RUN pip install poetry \
  && export PATH=$HOME/.local/bin:$PATH \
  && poetry config virtualenvs.create false \
  && poetry install --no-dev

CMD [ "lambda_function.handler" ]
