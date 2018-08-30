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
    module App
      #
      # A Thor based CLI wrapper for repository commands
      #
      class Repository < Base
        desc "list",
          "List all available repositories"

        long_desc <<-LONGDESC
          `list` will print out a list of the available repositories
          including the information for which platform it is available.
          You can display the list in different output formats and you
          can filter the list by any search criteria.

          With --format <format> option you can choose an output format
          with the available options table, json or plain. You can also
          use the shortcut options --table, --json or --plain.

          With --filter <filter> option you can limit the result of
          printed out elements. You can use any substring that is part
          of the found elements.
        LONGDESC

        method_option :format,
          type: :string,
          default: "table",
          banner: "<format>",
          desc: "Format of the output, valid formats are table, json or plain"

        method_option :table,
          type: :boolean,
          default: false,
          aliases: [],
          desc: "Format output as table, a shortcut for --format table option"

        method_option :json,
          type: :boolean,
          default: false,
          aliases: [],
          desc: "Format output as json, a shortcut for --format json option"

        method_option :plain,
          type: :boolean,
          default: false,
          aliases: [],
          desc: "Format output as plain text, a shortcut for --format plain option"

        method_option :filter,
          type: :string,
          default: nil,
          banner: "<filter>",
          desc: "Filter by criteria, display only data that contains filter"

        def list
          Command::Repository::List.new(
            *command_params
          ).execute
        rescue => e
          catch_errors(e)
        end

        desc "activate PLATFORM ARCH REPO",
          "Activate a repository for a platform on a specific architecture"

        long_desc <<-LONGDESC
          `activate PLATFORM ARCH REPO` will try to activate the
          specified repository for the specified platform and architecture.
        LONGDESC

        def activate(platform, arch, repo)
          Command::Repository::Activate.new(
            *command_params(
              platform: platform,
              arch: arch,
              repo: repo
            )
          ).execute
        rescue => e
          catch_errors(e)
        end

        desc "activate-all",
          "Activate all repositories"

        long_desc <<-LONGDESC
          `activate-all` will try to activate all available
          repositories.
        LONGDESC

        def activate_all
          Command::Repository::ActivateAll.new(
            *command_params
          ).execute
        rescue => e
          catch_errors(e)
        end

        desc "deactivate PLATFORM ARCH REPO",
          "Deactivate a repository for a platform on a specific architecture"

        long_desc <<-LONGDESC
          `deactivate PLATFORM ARCH REPO` will try to deactivate the
          specified repository for the specified platform and architecture.
        LONGDESC

        def deactivate(platform, arch, repo)
          Command::Repository::Deactivate.new(
            *command_params(
              platform: platform,
              arch: arch,
              repo: repo
            )
          ).execute
        rescue => e
          catch_errors(e)
        end

        desc "deactivate-all",
          "Deactivate all repositories"

        long_desc <<-LONGDESC
          `deactivate-all` will try to deactivate all available
          repositories.
        LONGDESC

        def deactivate_all
          Command::Repository::DeactivateAll.new(
            *command_params
          ).execute
        rescue => e
          catch_errors(e)
        end
      end
    end
  end
end
