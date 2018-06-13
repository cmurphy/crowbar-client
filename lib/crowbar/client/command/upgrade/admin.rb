#
# Copyright 2016, SUSE Linux GmbH
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

module Crowbar
  module Client
    module Command
      module Upgrade
        #
        # Implementation for the upgrade admin command
        #
        class Admin < Base
          include Mixin::UpgradeError

          def request
            @request ||= Request::Upgrade::Admin.new(
              args
            )
          end

          def execute
            request.process do |request|
              case request.code
              when 200
                say "Triggered Crowbar operating system upgrade"
                say "Wait until the admin server is fully upgraded and rebooted."
                if Config.defaults[:upgrade_versions] == "6-to-7"
                  say "Next step: 'crowbarctl upgrade database [new|connect]'"
                else
                  say "Next step: 'crowbarctl upgrade repocheck nodes'"
                end
              else
                err format_error(
                  request.parsed_response["error"], "admin"
                )
              end
            end
          end
        end
      end
    end
  end
end
