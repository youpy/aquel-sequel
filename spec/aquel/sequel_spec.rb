require File.dirname(__FILE__) + '/../spec_helper'

describe Aquel::Sequel do
  describe 'TSV parser' do
    let(:tsv_path) {
      File.dirname(__FILE__) + '/../test.tsv'
    }

    let(:aquel) {
      Aquel.define 'tsv' do
        has_header

        document do |attributes|
          open(attributes['path'])
        end

        item do |document|
          document.gets
        end

        split do |item|
          item.chomp.split(/\t/)
        end
      end
    }

    let(:db) {
      Sequel.connect('aquel:///', :database => aquel)
    }

    context 'simple query' do
      it 'finds matching line' do
        items = db.from('tsv').where(path: tsv_path).all

        expect(items.size).to eql(2)
        expect(items.first).to eql({"col1"=>"foo1", "col2"=>"bar1", "col3"=>"baz1"})

        items = db.select(:col1, :col3).from('tsv').where(path: tsv_path).all

        expect(items.size).to eql(2)
        expect(items.first).to eql({"col1"=>"foo1", "col3"=>"baz1"})
      end
    end

    context 'filter query' do
      it 'finds matching line' do
        items = db.from('tsv').where(path: tsv_path).where(col1: 'foo2').all

        expect(items.size).to eql(1)
        expect(items.first).to eql({"col1"=>"foo2", "col2"=>"bar2", "col3"=>"baz2"})

        items = db.select(:col1, :col3).from('tsv').where(path: tsv_path).where(col1: 'foo1').all

        expect(items.size).to eql(1)
        expect(items.first).to eql({"col1"=>"foo1", "col3"=>"baz1"})

        items = db.select(:col1, :col3).from('tsv').where(path: tsv_path).exclude(col1: 'foo1').all

        expect(items.size).to eql(1)
        expect(items.first).to eql({"col1"=>"foo2", "col3"=>"baz2"})
      end
    end
  end
end
