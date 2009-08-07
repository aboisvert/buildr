# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with this
# work for additional information regarding copyright ownership.  The ASF
# licenses this file to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the
# License for the specific language governing permissions and limitations under
# the License.


require 'buildr/core/project'
require 'buildr/core/common'

module Buildr
  module Eclipse
    module Scala
      include Extension

      NATURE = 'ch.epfl.lamp.sdt.core.scalanature'
      CLASSPATH_CONTAINER = 'ch.epfl.lamp.sdt.launching.SCALA_CONTAINER'
      BUILDER = 'ch.epfl.lamp.sdt.core.scalabuilder'

      after_define do |project|
        if project.compile.language == :scala || project.test.compile.language == :scala
          options = project.eclipse.options
          if options.natures == []
            options.natures = [NATURE, Buildr::Eclipse::Java::NATURE]
          end
          if options.classpath_containers == []
            options.classpath_containers = 
              [CLASSPATH_CONTAINER, Buildr::Eclipse::Java::CLASSPATH_CONTAINER]
          end
          options.builders.insert(0, BUILDER) unless options.builders.include? BUILDER 
        end
      end

    end
  end
end

class Buildr::Project
  include Buildr::Eclipse::Scala
end
