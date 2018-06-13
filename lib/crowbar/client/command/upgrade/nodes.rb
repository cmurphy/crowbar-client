#
# Copyright 2015, SUSE Linux GmbH
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
        # Implementation for the upgrade nodes command
        #
        class Nodes < Base
          include Mixin::UpgradeError

          def request
            @request ||= Request::Upgrade::Nodes.new(
              args
            )
          end

          def execute
            request.process do |request|
              case request.code
              when 200
                case args.component
                when "all"
                  say "Successfully triggered the upgrade of the nodes. "
                when "controllers"
                  say "Successfully triggered the upgrade of the controller nodes. "
                when "postpone"
                  say "The upgrade of compute nodes was postponed."
                when "resume"
                  say "The upgrade process was resumed, compute nodes could be upgraded now."
                else
                  say "Successfully triggered the upgrade of node #{args.component}. "
                end
                say "Query the upgrade status to follow the process with " \
                  "'crowbarctl upgrade status'."
              else
                err format_error(
                  request.parsed_response["error"], "nodes"
                )
              end
            end
          end
        end
      end
    end
  end
end
