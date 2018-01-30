# unworkable: Prehistoric, paranormal post-apocalyptic, dystopian, 
class Muse
  CONNECTORS = ["of the", "and the", "and", "and my", "and his", "and her"]
  CATEGORIES =  ["Adventure",
                 "Apocalypse",
                 "Science Fiction",
                 "Children",
                 "Comedy",
                 "Parody",
                 "Satire",
                 "Political satire",
                 "Education fiction",
                 "Graphic novel",
                 "Archeology",
                 "Mathematical fiction",
                 "Sports",
                 "Political satire",
                 "Pulp fiction",
                 "Fantasy",
                 "Sword and Sorcery",
                 "Computing",
                 "Psychology",
                 "Vampire fiction",
                 "Alien invasion",
                 "Cyberpunk",
                 "Steampunk",
                 "Wizardry",
                 "Farming",
                 "Thriller",
                 "Tragedy",
                 "Romance",
                 "Memoir",
                 "Spirituality",
                 "History",
                 "Biography",
                 "Autobiography",
                 "Genealogy",
                 "Law",
                 "Family",
                 "Historical",
                 "Horror",
                 "Mystery",
                 "Poetry",
                 "Metaphysics",
                 "Science",
                 "Cosmology",
                 "Theology",
                 "Hunting",
                 "Crime",
                 "Philosophy"]

  def initialize(term)
    @term = term
    @topics = topics(term)
  end

  def non_proper_nouns
    simplify_hash(include_tag(@topics, 'n').reject {|x| x['tags'].include?('prop')})
  end

  def adjectives
    simplify_hash(include_tag(@topics, 'adj')) + FFaker::Book::ADJ_AND_ADV
  end

  def verbs
    simplify_hash(include_tag(@topics, 'v'))
  end

  def simplify_hash(hash)
    hash.collect {|x| x['word'].titlecase}
  end

  def enough_nouns?
    non_proper_nouns.length > 15
  end

  def can_complex_title?
    verbs.length > 5 && enough_nouns? && adjectives.present?
  end

  def can_simple_title?
    enough_nouns?
  end

  def workable?
    can_complex_title? || can_simple_title?
  end

  def title
    if can_complex_title?
      case rand(0..1)
      when 0 then complex_title
      when 1 then simple_title
      end
    else
      simple_title
    end
  end

  def complex_title
    if can_complex_title?
      pre_adj_count = rand(0..1)
      post_adj_count = rand(0..1)
      [
        adjectives.sample(pre_adj_count),
        compound_subject(non_proper_nouns.sample, non_proper_nouns.sample),
        verbs.sample.downcase,
        "the",
        noun_with_modifier(non_proper_nouns.sample)
      ].flatten.join(" ")
    else
      ""
    end
  end

  def simple_title
    noun_one = noun_with_modifier(non_proper_nouns.sample)
    noun_two = noun_with_modifier(non_proper_nouns.sample)
    [
      noun_one,
      CONNECTORS.sample,
      noun_two
    ].join(" ")
  end

  def noun_with_modifier(noun)
    modifier = simplify_hash(self.class.modifier_for_noun(noun)).sample
    if modifier.present?
      "#{modifier.titlecase} #{noun}"
    else
      noun
    end
  end

  def compound_subject(noun_one, noun_two)
    [noun_one, CONNECTORS.sample, noun_two].join(' ')
  end

  def include_tag(list, part)
    list.select {|x| x['tags'].include?(part)}
  end

  def topics(term)
    topics = Datamuse.words(topics: @term)
    topics.reject {|x| x['tags'].blank? || x['word'] =~ /\s/}
  end

  def self.modifier_for_noun(noun)
    Datamuse.words(rel_jjb: noun)
  end
end
