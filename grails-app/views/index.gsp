<%@ page import="com.mbds.grails.User" %>
<%@ page import="com.mbds.grails.Annonce" %>
<%@ page import="com.mbds.grails.Illustration" %>

<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Lecoincoin</title>
</head>

<body>

<div id="content" role="main">
    <section class="row colset-2-its">
        <sec:ifLoggedIn>
            <h1 class="h1-annonce color-purple">Bienvenue <u>${User.findById(sec.loggedInUserInfo(field: 'id')).username}</u> <span
                    class="color-pink">!</span></h1>
            <sec:ifAnyGranted roles="ROLE_ADMIN, ROLE_MODERATOR">
                <h2 class="h2-annonce color-purple">Sur Lecoincoin, ${User.getCount()} utilisateurs proposent ${Annonce.getCount()} annonces avec ${Illustration.getCount()} illustrations !</h2>
            </sec:ifAnyGranted>

            <sec:ifAnyGranted roles="ROLE_CLIENT">
                <h2 class="h2-annonce color-lecoincoin"><u>Annonces publiées sur le site :</u></h2>
                <ul class="ul-annonce">

                    <g:each var="annonce" in="${Annonce.list()}">

                        <li class="li-annonce">
                            <div class="titre-annonce color-lecoincoin"><u>${annonce.title}</u></div>
                            <g:each var="illustration" in="${annonce.illustrations}">
                                <img class="img-annonce"
                                     src="${grailsApplication.config.illustrations.baseUrl + illustration.filename}"/>
                            </g:each>
                            <div class="desc-annonce">${annonce.description}</div>


                            <div class="prix-annonce">prix : ${annonce.price} €</div>

                            <div class="date-annonce">publié le <g:formatDate format="dd/MM/yyyy"
                                                                               date="${annonce.dateCreated}"/> par ${annonce.author.username}</div>

                        </li>

                    </g:each>
                </ul>

            </sec:ifAnyGranted>

        </sec:ifLoggedIn>
        <sec:ifNotLoggedIn>
            <h1>Lecoincoin fête ses 80 ans ! 🎂</h1>

            <p><a href="/login/index">Connectez-vous</a> pour commencer à vendre et acheter!</p>
            <img class="img80ans" src="${grailsApplication.config.illustrations.baseUrl + "anniv.png"}">
        </sec:ifNotLoggedIn>
    </section>
</div>

</body>
</html>
