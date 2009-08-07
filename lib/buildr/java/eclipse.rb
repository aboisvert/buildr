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
    module Java
      include Extension
      
      NATURE = 'org.eclipse.jdt.core.javanature'
      CLASSPATH_CONTAINER = 'org.eclipse.jdt.launching.JRE_CONTAINER'
      BUILDER = 'org.eclipse.jdt.core.javabuilder'
      
      after_define do |project|
        if project.compile.language == :java || project.test.compile.language == :java
          options = project.eclipse.options
          if options.natures == []
            options.natures = JAVA_NATURE 
          end
          if options.classpath_containers == []
            options.classpath_containers = CLASSPATH_CONTAINER
          end
          options.builders << BUILDER unless options.builders.include? BUILDER 
        end
      end
      
    end
  end
end

class Buildr::Project
  include Buildr::Eclipse::Java
end
