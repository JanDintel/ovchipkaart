# coding: utf-8
require 'spec_helper'

describe Ovchipkaart do

  describe 'configuration' do
    context 'valid configuration' do
      specify { expect{ subject.configure({ username: 'foo', password: 'bar' }) }.not_to raise_error }

      it 'sets the configuration' do
        subject.configure({ username: 'foo', password: 'bar' })
        expect(subject.config[:username]).to eql 'foo'
        expect(subject.config[:password]).to eql 'bar'
      end
    end

    context 'mandatory configuration' do
      specify { expect(subject.const_get :MANDATORY_CONFIGURATION).to eql({:username=>nil, :password=>nil}) }

      it 'raises an Ovchipkaart::ConfigurationError without the mandatory configuration' do
        expect{ subject.configure({ foo: 'bar' }) }.to raise_error Ovchipkaart::ConfigurationError, 'Username and password are mandatory configuration options'
      end
    end

    context 'configuration keys' do
      it 'raises an Ovchipkaart::ConfigurationError with invalid configuration keys' do
        expect{ subject.configure({ username: 'foo', password: 'bar', baz: 'foobar' }) }.to raise_error Ovchipkaart::ConfigurationError, 'Unknown configuration given'
      end
    end

    context 'YAML configuration' do
      it 'raises an Ovchipkaart::ConfigurationError without a YAML file' do
        expect{ subject.configure_with('') }.to raise_error Ovchipkaart::ConfigurationError, 'YAML configuration file not found'
      end

      it 'raises an Ovchipkaart::ConfigurationError with an invalid YAML file' do
        expect{ subject.configure_with('spec/fixtures/invalid_configuration.yml') }.to raise_error Ovchipkaart::ConfigurationError, 'YAML configuration file contains invalid syntax'
      end
    end
  end
end
