posts_repository = PostsRepository.new
posts_service = PostsService.new(posts_repository)

applications_repository = ApplicationsRepository.new
applications_service = ApplicationsService.new(applications_repository)

users_repository = UsersRepository.new
token_service = TokenService.new(users_repository)

DependencyContainer = {
  posts_repository: posts_repository,
  posts_service: posts_service,
  applications_repository: applications_repository,
  applications_service: applications_service,
  users_repository: users_repository,
  token_service: token_service,
}