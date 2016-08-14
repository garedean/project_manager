desc 'Outputs all projects and their todo items to the command line'
# Prints all non-deleted projects and non-deleted project items (default)
#
# Accepts optional argument: include_soft_deleted
# When 'include_soft_deleted' is included, all projects and items,
# included those that are flagged as 'deleted' in the database (soft deleted),
# are printed.
#
# Examples:
# rake print_project_summary
# rake print_project_summary[include_soft_deleted]
#
# Note for zsh users: brackets must be escaped when using this rake task:
# rake print_project_summary\[include_soft_deleted\]
task :print_project_summary, [:mode] => :environment do |task, args|
  @mode = args[:mode].try(:to_sym)
  validate_mode

  projects = projects_by_mode

  if projects.any?
    print_project_summaries(projects: projects)
  else
    puts "You don't have any projects."
  end
end

def validate_mode
  if @mode and @mode != :include_soft_deleted
    throw "Using #{mode} as an argument isn't supported. "\
        "Supported arguments: :include_soft_deleted."
  end
end

def projects_by_mode
  if @mode == :include_soft_deleted
    Project.all
  else
    Project.where(deleted: false)
  end
end

def project_items_by_mode(project:)
  if @mode == :include_soft_deleted
    project.items.all
  else
    project.items.where(deleted: false)
  end
end

def print_project_summaries(projects:)
  projects.each_with_index do |project, idx|
    puts project_summary(project: project, idx: idx)
    puts
  end
end

def project_summary(project:, idx:)
  item_summaries = item_summaries(project: project)

  [project_caption(project: project, idx: idx)].concat(item_summaries)
end

def item_summaries(project:)
  project_items = project_items_by_mode(project: project)

  project_items.each_with_object([]).with_index do |(item, output), idx|
    output << item_summary(item: item, idx: idx)
  end
end

def item_summary(item:, idx:)
  box_state = item.done? ? '[X]' : '[ ]'

  "- #{box_state} Todo: '#{item.action}'"
end

def project_caption(project:, idx:)
  "Project '#{project.title}'"
end
