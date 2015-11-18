library better_issue;

import 'package:angular2/angular2.dart';
import 'package:angular2/bootstrap.dart';

@Component(
    selector: 'my-app',
    templateUrl: 'app_component.html',
    directives: const [CORE_DIRECTIVES, FORM_DIRECTIVES])
class AppComponent {
  final Model model = new Model('kevmoo', 'better_issue');
}

class Model {
  String org;
  String repository;
  String issueTitle = 'Sample title';
  String issueBody = '# sample body\n\n*with markdown!*';

  Model(this.org, this.repository);

  Uri get issueUri {
    var segments = _getSegments().toList();

    var queryParams = <String, String>{};

    if (issueTitle != null && issueTitle.trim().isNotEmpty) {
      queryParams['title'] = issueTitle.trim();
    }

    if (issueBody != null && issueBody.trim().isNotEmpty) {
      queryParams['body'] = issueBody.trim();
    }

    if (queryParams.isEmpty) {
      queryParams = null;
    }

    return new Uri(
        scheme: 'https',
        host: 'github.com',
        pathSegments: segments,
        queryParameters: queryParams);
  }

  Iterable<String> _getSegments() sync* {
    if (org == null || org.trim().isEmpty) return;

    yield org.trim();

    if (repository == null || repository.trim().isEmpty) return;

    yield repository.trim();

    yield* ['issues', 'new'];
  }
}

main() {
  bootstrap(AppComponent);
}
