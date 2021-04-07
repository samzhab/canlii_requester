#!/usr/bin/env ruby
# frozen_string_literal: true

# Copyright (c) 2021 Samuel Y. Ayele
require 'json'
require 'addressable'
require 'rest-client'
require 'byebug'
require 'nokogiri'
require 'csv'
require 'down'
require 'fileutils'
# ------------------------------------------------------------------------------
class CanliiRequester
  # LETTERS = %w(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z).freeze
  #
  # BASE_URL = 'https://laws-lois.justice.gc.ca/'
  # ACTS_URL = 'eng/acts/'

  # def crawl
  #   all_acts = []
  #   create_folders
  #   LETTERS.each do |index|
  #     index_acts = []
  #     create_index_folders(index)
  #     begin
  #       response = get_request("#{BASE_URL}#{ACTS_URL}#{index}.html", {})
  #     rescue RestClient::ExceptionWithResponse => e
  #       display_error(e, "#{BASE_URL}#{ACTS_URL}#{index}.html")
  #     end
  #     targeted_acts_content = target_acts_content(response)
  #     act_details = extract_acts_details(targeted_acts_content, index_acts, index)
  #     all_acts << act_details
  #     write_one_to_file(index_acts, index, act_details)
  #   end
  #   write_all_to_file(all_acts)
  # end

  # def extract_acts_details(targeted_acts_content, index_acts, _index)
  #   act_details = {}
  #   targeted_acts_content.children.each do |act|
  #     next if act.children.count < 1
  #
  #     act_details = get_details(act)
  #     index_acts << act_details
  #   end
  #   act_details
  # end

  # def target_acts_content(response)
  #   Nokogiri::HTML(response).css('.wet-boew-zebra')
  # end

  # def create_folders
  #   Process.spawn('mkdir PDFs && mkdir JSONs && mkdir HTMLs')
  #   # Process.spawn("mkdir XMLs")
  # end

  # def create_index_folders(index)
  #   Process.spawn("mkdir PDFs/#{index} && mkdir JSONs/#{index} && mkdir HTMLs/#{index}")
  #   # Process.spawn("mkdir XMLs/#{index}")
  # end

  # def write_all_to_file(all_acts)
  #   File.write('JSONs/all_parliament_acts.json',
  #              JSON.dump(all_acts))
  # end

  # def get_more_details(act)
  #   more_details = { has_regulations: false, repealed: false }
  #   more_details[:has_regulations] = true if act.children[2].content
  #                                               .strip == 'R'
  #   more_details[:repealed] = true if act.children[0].content.strip[/Repealed/]
  #   more_details
  # end

  def get_request(url, headers)
    RestClient::Request.execute(method: :get,
                                url: Addressable::URI.parse(url)
                                           .normalize.to_str,
                                headers: headers,
                                timeout: 50)
  end
end

# bc_cap_crawler = CanliiRequester.new
# bc_cap_crawler.crawl
