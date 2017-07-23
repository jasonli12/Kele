module RoadmapsAndCheckpoints
  def get_roadmap(roadmap_id)
    url = 'https://www.bloc.io/api/v1/roadmaps/' + roadmap_id.to_s
    get_parse(url)
  end

  def get_checkpoint(checkpoint_id)
    url = 'https://www.bloc.io/api/v1/checkpoints/' + checkpoint_id.to_s
    get_parse(url)
  end
end
