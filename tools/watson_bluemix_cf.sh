#!/bin/bash
#
# (C) Copyright IBM Corporation 2017, 2017
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

set -eo pipefail

tool_dir="$(dirname "$0")"
source "$tool_dir/common_functions.sh"

rootdir=".."

# git clone https://github.com/ibmruntimes/java.bluemix.demos.git

check_docker
check_cf_cli
check_bluemix_cli

pull_maven_image

pushd $rootdir/samples/watson-springboot
maven_compile_app

check_login
# bx login -a https://api.ng.bluemix.net

echo "pushing the app"
bx cf push -f maven_manifest.yml
popd

echo "Visit http://watson-springboot20.mybluemix.net to access the app."
