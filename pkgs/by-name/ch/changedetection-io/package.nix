{
  lib,
  fetchFromGitHub,
  python3Packages,
}:

python3Packages.buildPythonApplication (finalAttrs: {
  pname = "changedetection-io";
  version = "0.60.9";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "dgtlmoon";
    repo = "changedetection.io";
    tag = finalAttrs.version;
    hash = "sha256-E7ujQNMG1Qs6NAocAOYP8My8PDfFrI1ejoEIJfvC5VQ=";
  };

  build-system = [ python3Packages.setuptools ];

  pythonRelaxDeps = [
    "apprise"
    "chardet"
    "elementpath"
    "greenlet"
    "jsonpath-ng"
    "puremagic"
    "pydantic"
    "pyppeteer-ng"
    "python-engineio"
    "selenium"
    "werkzeug"
  ];

  pythonRemoveDeps = [
    # Unpackaged; content_fetchers/puppeteer.py skips stealth injection when unavailable.
    "pyppeteerstealth"
    "pytest"
    "pytest-flask"
    "pytest-mock"
    "pytest-xdist"
  ];

  dependencies =
    with python3Packages;
    [
      apprise
      arrow
      babel
      beautifulsoup4
      blinker
      brotli
      chardet
      cryptography
      diff-match-patch
      elementpath
      extruct
      feedgen
      feedparser
      flask
      flask-babel
      flask-compress
      flask-cors
      flask-login
      flask-paginate
      flask-restful
      flask-socketio
      flask-wtf
      gevent
      greenlet
      inscriptis
      jinja2
      jq
      jsonpath-ng
      jsonschema
      linkify-it-py
      litellm
      loguru
      lxml
      openapi-core
      openpyxl
      orjson
      paho-mqtt
      panzi-json-logic
      playwright
      pluggy
      price-parser
      psutil
      puremagic
      pydantic
      pyppeteer-ng
      python-engineio
      python-socketio
      pytz
      rank-bm25
      rapidfuzz
      referencing
      requests
      requests-file
      segno
      selenium
      timeago
      tzdata
      validators
      werkzeug
      wtforms
    ]
    ++ requests.optional-dependencies.socks
    ++ openapi-core.optional-dependencies.flask;

  # Match unit-tests in upstream .github/workflows/test-stack-reusable-workflow.yml.
  enabledTestPaths = [
    "changedetectionio/tests/unit"
    "changedetectionio/tests/llm"
  ];

  nativeCheckInputs = with python3Packages; [
    pytestCheckHook
    pytest-flask
    pytest-mock
  ];

  __darwinAllowLocalNetworking = true;

  pythonImportsCheck = [ "changedetectionio" ];

  meta = {
    description = "Self-hosted free open source website change detection tracking, monitoring and notification service";
    homepage = "https://github.com/dgtlmoon/changedetection.io";
    changelog = "https://github.com/dgtlmoon/changedetection.io/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [
      mikaelfangel
      thanegill
    ];
    mainProgram = "changedetection.io";
  };
})
