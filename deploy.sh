#!/bin/bash

hugo -d docs

git add -A
git commit -m "update"
git push -u origin main
