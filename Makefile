.PHONY: all build login push run

NAME     		 		:= rosscdh/rester-tester
TAG      		 		:= $$(git log -1 --pretty=%h)
CURRENT_RELEASE_TAG 	:= $$(bash scripts/current_version.sh)
VERSION  		 		:= ${NAME}:${TAG}
LATEST   		 		:= ${NAME}:latest

K8S_ENV					?= dev

BUILD_REPO_ORIGIN=$$(git config --get remote.origin.url)
BUILD_COMMIT_SHA1:=$$(git rev-parse --short HEAD)
BUILD_COMMIT_DATE:=$$(git log -1 --date=short --pretty=format:%ct)
BUILD_BRANCH:=$$(git symbolic-ref --short HEAD)
BUILD_DATE:=$$(date -u +"%Y-%m-%dT%H:%M:%SZ")

export

all: build login push

build:
	docker build -t ${LATEST} -t ${VERSION} \
		--build-arg BUILD_COMMIT_SHA1=${BUILD_COMMIT_SHA1} \
		--build-arg BUILD_COMMIT_DATE=${BUILD_COMMIT_DATE} \
		--build-arg BUILD_BRANCH=${BUILD_BRANCH} \
		--build-arg BUILD_DATE=${BUILD_DATE} \
		--build-arg BUILD_REPO_ORIGIN=${BUILD_REPO_ORIGIN} \
		.
