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
    module Request
      module Proposal
      end
    end
  end
end

require_relative "proposal/commit"
require_relative "proposal/create"
require_relative "proposal/delete"
require_relative "proposal/dequeue"
require_relative "proposal/list"
require_relative "proposal/show"
require_relative "proposal/template"
require_relative "proposal/update"
