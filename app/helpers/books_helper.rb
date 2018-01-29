module BooksHelper
  def random_publication
    FFaker::AddressUS.city + " " + ["Times", "Post", "Citizen Enquirer", "Post-Gazette"].sample
  end
  def random_adj
    ["riveting","heartwarming","intense", "extreme", "impassioned"].sample
  end
  def random_desc(sentences = 2)
    markov = MarkyMarkov::Dictionary.new('dictionary')
    markov.parse_file(File.join(Rails.root,'lib','dict.txt'))
    markov.generate_n_sentences sentences
  end
end
