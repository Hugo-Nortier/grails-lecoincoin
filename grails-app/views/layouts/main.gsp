<!doctype html>
<html lang="en" class="no-js">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>
        <g:layoutTitle default="Grails"/>
    </title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <asset:link rel="icon" href="favicon.ico" type="image/x-ico" />

    <asset:stylesheet src="application.css"/>

    <g:layoutHead/>
</head>
<body>

    <div class="navbar navbar-default navbar-static-top" role="navigation">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="/#">
		    <asset:image src="lecoincoin.png" alt="Lecoincoin Logo"/>
                </a>
            </div>
            <div class="navbar-collapse collapse" aria-expanded="false" style="height: 0.8px;">
                <ul class="nav navbar-nav navbar-right">
                    <sec:ifLoggedIn>
                        <sec:ifAnyGranted roles="ROLE_ADMIN, ROLE_MODERATOR">
                            <sec:ifAnyGranted roles="ROLE_ADMIN">
                                <li class="nav-item mr-3">
                        <a class="nav-link" href="/user/index">👪 Utilisateurs</a>
                    </li>
                            </sec:ifAnyGranted>
                    <li class="nav-item mr-3">
                        <a class="nav-link" href="/annonce/index">📣 Annonces</a>
                    </li>
                        </sec:ifAnyGranted>

                        <sec:ifAnyGranted roles="ROLE_CLIENT">
                            <li class="nav-item mr-3">
                                <a class="nav-link" href="/annonce/index">🗣 Vos annonces</a>
                            </li>
                        </sec:ifAnyGranted>
                        <li class="nav-item mr-3">
                            <a class="nav-link" style="background-color: #FF6E14;text-shadow: -1px -1px 0 #000, 1px -1px 0 #000, -1px 1px 0 #000, 1px 1px 0 #000;" href="/logout/index">🚪 Se déconnecter</a>
                        </li>
                    </sec:ifLoggedIn>
                    <sec:ifNotLoggedIn>
                        <li class="nav-item mr-3">
                            <a class="nav-link" style="background-color: #FF6E14;text-shadow: -1px -1px 0 #000, 1px -1px 0 #000, -1px 1px 0 #000, 1px 1px 0 #000;" href="/login/index">🟠 Se Connecter</a>
                        </li>
                    </sec:ifNotLoggedIn>

                </ul>
            </div>
        </div>
    </div>

    <g:layoutBody/>

    <div class="footer" role="contentinfo"></div>

    <div id="spinner" class="spinner" style="display:none;">
        <g:message code="spinner.alt" default="Loading&hellip;"/>
    </div>

    <asset:javascript src="application.js"/>

</body>
</html>
