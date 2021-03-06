#
# Author:: Ranjib Dey (<ranjib@pagerduty.com>)
# Copyright:: Copyright (c) 2014 PagerDuty, Inc.
# License:: Apache License, Version 2.0
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

require 'spec_helper'

describe Blender do
  describe '#blend' do
    it 'should invoke a local command is no block is given' do
      cmd = double(Mixlib::ShellOut, exitstatus: 0).as_null_object
      expect(Mixlib::ShellOut).to receive(:new).with('foo', {}).and_return(cmd)
      described_class.blend('foo')
    end
    it 'should yield a scheduler object when block passed' do
      x = 1
      described_class.blend('test') do |sched|
        sched.ruby_task 'foo' do
          x = 100
        end
      end
      expect(x).to eq(100)
    end
  end
end
