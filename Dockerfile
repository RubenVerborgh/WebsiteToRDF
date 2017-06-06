FROM bdevloed/eye:latest

RUN apt-get update -y
RUN apt-get install -y build-essential
RUN apt-get install -y python
RUN apt-get install -y python-pip
RUN apt-get install -y git
RUN apt-get install -y wget
RUN apt-get -y install unzip

# install rdflib
RUN pip install rdflib
RUN pip install html5lib

# install serd
RUN git clone https://github.com/drobilla/serd.git
WORKDIR serd
RUN ./waf configure
RUN ./waf
RUN ./waf install

WORKDIR /

# installing prolog
#RUN apt-get -y update && apt-get -y install libgmp-dev && apt-get -y install swi-prolog

# install cturtle
RUN apt-get -y install flex
RUN wget -O "cturtle.zip" "https://github.com/melgi/cturtle/archive/v1.0.5.zip"
RUN unzip "cturtle.zip" -d "./"
RUN rm "cturtle.zip"
RUN cd "./cturtle-1.0.5" && make install

WORKDIR /WebsiteToRDF

COPY ontologies ontologies
COPY extract-website-data .
COPY rdfa2ttl .
COPY docker/run.sh .

ENTRYPOINT ["./run.sh"]i


