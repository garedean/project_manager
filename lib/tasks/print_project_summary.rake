desc 'Outputs all projects and their todo items to the command line'
task :print_project_summary => :environment do
  Project.all.each_with_index do |project, idx|
    puts project_summary(project: project, idx: idx)
    puts
  end
end

def project_summary(project:, idx:)
  item_summaries = item_summaries(project: project)

  [project_caption(project: project, idx: idx)].concat(item_summaries)
end

def item_summaries(project:)
  project.items.each_with_object([]).with_index do |(item, output), idx|
    output << item_summary(item: item, idx: idx)
  end
end

def item_summary(item:, idx:)
  box_state = item.done? ? '[X]' : '[ ]'

  "- #{box_state} Todo Item #{idx + 1}"
end

def project_caption(project:, idx:)
  "Project #{(idx + 1).humanize.capitalize}"
end
