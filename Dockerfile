FROM debian:trixie-slim
COPY main /main
EXPOSE 4444
CMD ["/main"]
