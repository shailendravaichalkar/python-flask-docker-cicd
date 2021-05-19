RUN mkdir /code
WORKDIR /code
ADD . /code/
RUN pip install -r requirements.txt

EXPOSE 9090
CMD ["python", "/code/helloWorld.py"]