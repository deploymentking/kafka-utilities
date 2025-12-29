# This is the Dockerfile that is the source for deploymentking/kafka-utilities:latest
# Builder stage with Go
FROM --platform=$BUILDPLATFORM golang:alpine AS builder
ARG TARGETPLATFORM
ARG GOARCH
RUN GOARCH=$GOARCH go install github.com/birdayz/kaf/cmd/kaf@latest
RUN GOARCH=$GOARCH go install github.com/deviceinsight/kafkactl/v5@latest
RUN GOARCH=$GOARCH go install github.com/segmentio/topicctl/cmd/topicctl@latest

FROM alpine:latest
RUN apk add --no-cache curl jq bash
COPY --from=builder /go/bin/kaf /usr/bin/kaf
COPY --from=builder /go/bin/kafkactl /usr/bin/kafkactl
COPY --from=builder /go/bin/topicctl /usr/bin/topicctl
CMD ["/bin/sh"]
