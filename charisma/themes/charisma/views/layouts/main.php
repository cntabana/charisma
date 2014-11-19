<!DOCTYPE html>
<html lang="en">
<head>
	<!--
		Charisma v1.0.0

		Copyright 2012 Muhammad Usman
		Licensed under the Apache License v2.0
		http://www.apache.org/licenses/LICENSE-2.0

		http://usman.it
		http://twitter.com/halalit_usman
	-->
	<meta charset="utf-8">
	<title><?php echo Chtml::encode($this->pageTitle); ?></title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="description" content="Cyuda, a fully featured, responsive, HTML5, Bootstrap admin template.">
	<meta name="author" content="Ntabana Coco">

	<!-- The styles -->
	<link id="bs-css" href="<?php echo Yii::app()->theme->baseUrl;?>/css/bootstrap-classic.css" rel="stylesheet">

	                              
	<style type="text/css">
	  body {
		padding-bottom: 40px;
	  }
	  .sidebar-nav {
		padding: 9px 0;
	  }
	</style>
	<link href="<?php echo Yii::app()->theme->baseUrl;?>/css/bootstrap-responsive.css" rel="stylesheet">
	<link href="<?php echo Yii::app()->theme->baseUrl;?>/css/charisma-app.css" rel="stylesheet">
	<link href="<?php echo Yii::app()->theme->baseUrl;?>/css/jquery-ui-1.8.21.custom.css" rel="stylesheet">
	<link href='<?php echo Yii::app()->theme->baseUrl;?>/css/fullcalendar.css' rel='stylesheet'>
	<link href='<?php echo Yii::app()->theme->baseUrl;?>/css/fullcalendar.print.css' rel='stylesheet'  media='print'>
	<link href='<?php echo Yii::app()->theme->baseUrl;?>/css/chosen.css' rel='stylesheet'>
	<link href='<?php echo Yii::app()->theme->baseUrl;?>/css/uniform.default.css' rel='stylesheet'>
	<link href='<?php echo Yii::app()->theme->baseUrl;?>/css/colorbox.css' rel='stylesheet'>
	<link href='<?php echo Yii::app()->theme->baseUrl;?>/css/jquery.cleditor.css' rel='stylesheet'>
	<link href='<?php echo Yii::app()->theme->baseUrl;?>/css/jquery.noty.css' rel='stylesheet'>
	<link href='<?php echo Yii::app()->theme->baseUrl;?>/css/noty_theme_default.css' rel='stylesheet'>
	<link href='<?php echo Yii::app()->theme->baseUrl;?>/css/elfinder.min.css' rel='stylesheet'>
	<link href='<?php echo Yii::app()->theme->baseUrl;?>/css/elfinder.theme.css' rel='stylesheet'>
	<link href='<?php echo Yii::app()->theme->baseUrl;?>/css/jquery.iphone.toggle.css' rel='stylesheet'>
	<link href='<?php echo Yii::app()->theme->baseUrl;?>/css/opa-icons.css' rel='stylesheet'>
	<link href='<?php echo Yii::app()->theme->baseUrl;?>/css/uploadify.css' rel='stylesheet'>

	<!-- The HTML5 shim, for IE6-8 support of HTML5 elements -->
	<!--[if lt IE 9]>
	  <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
	<![endif]-->

	<!-- The fav icon -->
	<link rel="shortcut icon" href="<?php echo Yii::app()->theme->baseUrl;?>/img/favicon.ico">
		
</head>

<body>
	
		<!-- topbar starts -->
	<div class="navbar">
		<div class="navbar-inner">
			<div class="container-fluid">
				<a class="btn btn-navbar" data-toggle="collapse" data-target=".top-nav.nav-collapse,.sidebar-nav.nav-collapse">
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</a>
				<a class="brand" href="#"> <img alt="UNR Mutuelle Logo" src="<?php echo Yii::app()->theme->baseUrl;?>/img/logo20.png" /> <span>Mutuelle</span></a>
				
				<!-- theme selector starts -->
			<!--	<div class="btn-group pull-right theme-container" >
					<a class="btn dropdown-toggle" data-toggle="dropdown" href="#">
						<i class="icon-tint"></i><span class="hidden-phone"> Change Theme / Skin</span>
						<span class="caret"></span>
					</a>
					<ul class="dropdown-menu" id="themes">
						<li><a data-value="classic" href="#"><i class="icon-blank"></i> Classic</a></li>
						<li><a data-value="cerulean" href="#"><i class="icon-blank"></i> Cerulean</a></li>
						<li><a data-value="cyborg" href="#"><i class="icon-blank"></i> Cyborg</a></li>
						<li><a data-value="redy" href="#"><i class="icon-blank"></i> Redy</a></li>
						<li><a data-value="journal" href="#"><i class="icon-blank"></i> Journal</a></li>
						<li><a data-value="simplex" href="#"><i class="icon-blank"></i> Simplex</a></li>
						<li><a data-value="slate" href="#"><i class="icon-blank"></i> Slate</a></li>
						<li><a data-value="spacelab" href="#"><i class="icon-blank"></i> Spacelab</a></li>
						<li><a data-value="united" href="#"><i class="icon-blank"></i> United</a></li>
					</ul>
				</div>
				 theme selector ends -->
				
				<!-- user dropdown starts -->
				<div class="btn-group pull-right" >
					<a class="btn dropdown-toggle" data-toggle="dropdown" href="#">
						<i class="icon-user"></i><span class="hidden-phone"> 
						<?php 
                        if(isset(Yii::app()->session['username']))
						echo Yii::app()->session['username']; 
                        else
                        	echo "Click here to login";
						?>

					</span>
						<span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
					<?php 
                     if(isset(Yii::app()->session['username'])){
					?>
					
						<li><a href="?r=users/changePasswordUser&p=profile">Profile</a></li>
						<li class="divider"></li>
						<li><a href="?r=site/logout">Logout</a></li>
					
					<?php
                     }
                     else
                     {
                    ?>
                   
                     	<li><a href="?r=site/login">Login</a></li>
                     	<li class="divider"></li>

                    <?php
                     }
					?>	
				</ul>
			    </div>
				<!-- user dropdown ends -->
				<?php
				 if(isset(Yii::app()->session['username'])){
					?>
				<div class="top-nav nav-collapse">
					<ul class="nav">
						<li><a href="#">Visit Site</a></li>
						<li>
							<form class="navbar-search pull-left" Method='Post' action='?r=members/admin'>
								<input placeholder="Search" class="search-query span2" name="cardNumberSearch" type="text">
							    <input class="search-query span1" value="Search" type="submit">
							
							</form>
						</li>
					</ul>
				</div><!--/.nav-collapse -->
				<?php } ?>
			</div>
		</div>
	</div>
	<!-- topbar ends -->
		<div class="container-fluid">
		<div class="row-fluid">
				
			<!-- left menu starts -->
			<div class="span2 main-menu-span">
				<div class="well nav-collapse sidebar-nav">
					<?php 
              if(isset(Yii::app()->session['username'])){

                     	if(Yii::app()->session['group'] == 1){
					?>
					<ul class="nav nav-tabs nav-stacked main-menu">

						<li class="nav-header hidden-tablet">Main</li>						
					    <li><a class="ajax-link" href="?r=site/dashboard"><i class="icon-home"></i><span class="hidden-tablet"> Dashboard</span></a></li>
						<li><a class="ajax-link" href="?r=members/admin"><i class="icon-eye-open"></i><span class="hidden-tablet"> Members</span></a></li>
						<li><a class="ajax-link" href="?r=beneficaire/admin"><i class="icon-edit"></i><span class="hidden-tablet"> Dependants</span></a></li>
						<li><a class="ajax-link" href="?r=invoice/admin"><i class="icon-globe"></i><span class="hidden-tablet"> Invoice</span></a></li>
                       <li><a href="?r=site/logout"><i class="icon-lock"></i><span class="hidden-tablet"> Logout</span></a></li>
					</ul>
					
					<?php 
				}

				
				if(Yii::app()->session['group'] == 2){
					?>
					<ul class="nav nav-tabs nav-stacked main-menu">

						<li class="nav-header hidden-tablet">Main</li>						
					    <li><a class="ajax-link" href="?r=site/dashboard"><i class="icon-home"></i><span class="hidden-tablet"> Dashboard</span></a></li>
						<li><a class="ajax-link" href="?r=members/admin"><i class="icon-eye-open"></i><span class="hidden-tablet"> Members</span></a></li>
						<li><a class="ajax-link" href="?r=beneficaire/admin"><i class="icon-edit"></i><span class="hidden-tablet"> Dependants</span></a></li>
						<li><a class="ajax-link" href="?r=drugs/admin"><i class="icon-th"></i><span class="hidden-tablet"> Pharmacy</span></a></li>
						<li><a class="ajax-link" href="?r=invoice/admin"><i class="icon-globe"></i><span class="hidden-tablet"> Invoice</span></a></li>
                     
						<li><a href="?r=site/logout"><i class="icon-lock"></i><span class="hidden-tablet"> Logout</span></a></li>
					
					</ul>
					
					<?php 
				}
				if(Yii::app()->session['group'] == 3){
					?>
					<ul class="nav nav-tabs nav-stacked main-menu">

						<li><a href="?r=invoice/admin"><i class="icon-globe"></i><span class="hidden-tablet"> Invoice</span></a></li>
						<li><a href="?r=site/logout"><i class="icon-lock"></i><span class="hidden-tablet"> Logout</span></a></li>
					</ul>
					<?php 
				}
				if(Yii::app()->session['group'] == 4){
					?>
					<ul class="nav nav-tabs nav-stacked main-menu">

						<li class="nav-header hidden-tablet">Main</li>						
					    <li><a class="ajax-link" href="?r=site/dashboard"><i class="icon-home"></i><span class="hidden-tablet"> Dashboard</span></a></li>
						<li><a class="ajax-link" href="?r=users/admin"><i class="icon-align-justify"></i><span class="hidden-tablet"> Users</span></a></li>
						<li><a href="?r=site/logout"><i class="icon-lock"></i><span class="hidden-tablet"> Logout</span></a></li>
					</ul>
					<?php 
				}

				if(Yii::app()->session['group'] == 5){
					?>
					<ul class="nav nav-tabs nav-stacked main-menu">

						<li class="nav-header hidden-tablet">Main</li>						
					    <li><a class="ajax-link" href="?r=site/dashboard"><i class="icon-home"></i><span class="hidden-tablet"> Dashboard</span></a></li>
						<li><a class="ajax-link" href="?r=members/admin"><i class="icon-eye-open"></i><span class="hidden-tablet"> Members</span></a></li>
						<li><a class="ajax-link" href="?r=beneficaire/admin"><i class="icon-edit"></i><span class="hidden-tablet"> Dependants</span></a></li>
						<li><a class="ajax-link" href="?r=hospital/admin"><i class="icon-picture"></i><span class="hidden-tablet"> Partner Hospital and Clinics</span></a></li>
						<li><a class="ajax-link" href="?r=service/admin"><i class="icon-list-alt"></i><span class="hidden-tablet"> Services</span></a></li>
						<li><a class="ajax-link" href="?r=traitement/admin"><i class="icon-font"></i><span class="hidden-tablet"> Medical Acts</span></a></li>
						<li><a class="ajax-link" href="?r=drugs/admin"><i class="icon-th"></i><span class="hidden-tablet"> Pharmacy</span></a></li>
						<li><a href="?r=invoice/admin"><i class="icon-globe"></i><span class="hidden-tablet"> Invoice</span></a></li>
						
						<li class="nav-header hidden-tablet">Settings</li>
						<li><a class="ajax-link" href="?r=users/admin"><i class="icon-align-justify"></i><span class="hidden-tablet"> Users</span></a></li>
						<li><a class="ajax-link" href="?r=backup"><i class="icon-calendar"></i><span class="hidden-tablet"> Backup</span></a></li>
						<li><a class="ajax-link" href="?r=importcsv"><i class="icon-folder-open"></i><span class="hidden-tablet"> File Manager</span></a></li>
						 <li><a class="ajax-link" href="?r=province/admin"><i class="icon-star"></i><span class="hidden-tablet"> UR</span></a></li>
						<li><a href="?r=district/admin"><i class="icon-ban-circle"></i><span class="hidden-tablet"> Colleges</span></a></li>
						<li><a href="?r=sector/admin"><i class="icon-list-alt"></i><span class="hidden-tablet"> Departments</span></a></li>
						
						<li><a href="?r=site/logout"><i class="icon-lock"></i><span class="hidden-tablet"> Logout</span></a></li>
					</ul>
					<label id="for-is-ajax" class="hidden-tablet" for="is-ajax"><input id="is-ajax" type="checkbox"> Ajax on menu</label>
			
					<?php 
				}
                     	if(Yii::app()->session['group'] == 6){
					?>
					<ul class="nav nav-tabs nav-stacked main-menu">

						<li><a class="ajax-link" href="?r=drugs/admin"><i class="icon-th"></i><span class="hidden-tablet"> Pharmacy</span></a></li>						
						<li><a class="ajax-link" href="?r=invoice/admin"><i class="icon-globe"></i><span class="hidden-tablet"> Invoice</span></a></li>
                      <li><a href="?r=site/logout"><i class="icon-lock"></i><span class="hidden-tablet"> Logout</span></a></li>
					</ul>
					<label id="for-is-ajax" class="hidden-tablet" for="is-ajax"><input id="is-ajax" type="checkbox"> Ajax on menu</label>
			
					<?php 
				}
		} else{
				    ?>
				    <ul class="nav nav-tabs nav-stacked main-menu">
				    	<li><a class="ajax-link" href="index.php?r=site/login"><i class="icon-home"></i><span class="hidden-tablet"> Login</span></a></li>
						
				    </ul>
		<?php
	        }
		?>
						</div><!--/.well -->
			</div><!--/span-->
			<!-- left menu ends -->
			
			<noscript>
				<div class="alert alert-block span10">
					<h4 class="alert-heading">Warning!</h4>
					<p>You need to have <a href="http://en.wikipedia.org/wiki/JavaScript" target="_blank">JavaScript</a> enabled to use this site.</p>
				</div>
			</noscript>
			
			<div id="content" class="span10">
			<!-- content starts -->
			

			<div>
				<ul class="breadcrumb">
					<li>
						<a href="#">Home</a> <span class="divider">/</span>
					</li>
					<li>
						<a href="?r=<?php echo $this->uniqueid;?>/admin"><?php  echo $this->uniqueid ?></a><span class="divider">/</span>
					</li>
					<li>
						<a href="#"><?php echo $this->action->Id;?></a>
					</li>
				</ul>
			</div>

			<!-- ------------------------------------------------------------------------------- -->
			

			
		
					
			

		
            
		     <?php echo $content; ?>
       
					<!-- content ends -->
			</div><!--/#content.span10-->
				</div><!--/fluid-row-->
				
		<hr>

		<div class="modal hide fade" id="myModal">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">×</button>
				<h3>Settings</h3>
			</div>
			<div class="modal-body">
				<p>Here settings can be configured...</p>
			</div>
			<div class="modal-footer">
				<a href="#" class="btn" data-dismiss="modal">Close</a>
				<a href="#" class="btn btn-primary">Save changes</a>
			</div>
		</div>

		<footer>
			<p class="pull-left">&copy; <a href="http://usman.it" target="_blank">Cyudaltd</a> 2014</p>
			<p class="pull-right">Powered by: <a href="cyudaltd.com">Cyudaltd</a></p>
		</footer>
		
	</div><!--/.fluid-container-->

	<!-- external javascript
	================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->

	<!-- jQuery <script src="<?php //echo Yii::app()->theme->baseUrl;?>/js/jquery-1.7.2.min.js"></script> -->
	
	<!-- jQuery UI -->
	<script src="<?php echo Yii::app()->theme->baseUrl;?>/js/jquery-ui-1.8.21.custom.min.js"></script>
	<!-- transition / effect library -->
	<script src="<?php echo Yii::app()->theme->baseUrl;?>/js/bootstrap-transition.js"></script>
	<!-- alert enhancer library -->
	<script src="<?php echo Yii::app()->theme->baseUrl;?>/js/bootstrap-alert.js"></script>
	<!-- modal / dialog library -->
	<script src="<?php echo Yii::app()->theme->baseUrl;?>/js/bootstrap-modal.js"></script>
	<!-- custom dropdown library -->
	<script src="<?php echo Yii::app()->theme->baseUrl;?>/js/bootstrap-dropdown.js"></script>
	<!-- scrolspy library -->
	<script src="<?php echo Yii::app()->theme->baseUrl;?>/js/bootstrap-scrollspy.js"></script>
	<!-- library for creating tabs -->
	<script src="<?php echo Yii::app()->theme->baseUrl;?>/js/bootstrap-tab.js"></script>
	<!-- library for advanced tooltip -->
	<script src="<?php echo Yii::app()->theme->baseUrl;?>/js/bootstrap-tooltip.js"></script>
	<!-- popover effect library -->
	<script src="<?php echo Yii::app()->theme->baseUrl;?>/js/bootstrap-popover.js"></script>
	<!-- button enhancer library -->
	<script src="<?php echo Yii::app()->theme->baseUrl;?>/js/bootstrap-button.js"></script>
	<!-- accordion library (optional, not used in demo) -->
	<script src="<?php echo Yii::app()->theme->baseUrl;?>/js/bootstrap-collapse.js"></script>
	<!-- carousel slideshow library (optional, not used in demo) -->
	<script src="<?php echo Yii::app()->theme->baseUrl;?>/js/bootstrap-carousel.js"></script>
	<!-- autocomplete library -->
	<script src="<?php echo Yii::app()->theme->baseUrl;?>/js/bootstrap-typeahead.js"></script>
	<!-- tour library -->
	<script src="<?php echo Yii::app()->theme->baseUrl;?>/js/bootstrap-tour.js"></script>
	<!-- library for cookie management -->
	<script src="<?php echo Yii::app()->theme->baseUrl;?>/js/jquery.cookie.js"></script>
	<!-- calander plugin -->
	<script src='<?php echo Yii::app()->theme->baseUrl;?>/js/fullcalendar.min.js'></script>
	<!-- data table plugin -->
	<script src='<?php echo Yii::app()->theme->baseUrl;?>/js/jquery.dataTables.min.js'></script>

	<!-- chart libraries start -->
	<script src="<?php echo Yii::app()->theme->baseUrl;?>/js/excanvas.js"></script>
	<script src="<?php echo Yii::app()->theme->baseUrl;?>/js/jquery.flot.min.js"></script>
	<script src="<?php echo Yii::app()->theme->baseUrl;?>/js/jquery.flot.pie.min.js"></script>
	<script src="<?php echo Yii::app()->theme->baseUrl;?>/js/jquery.flot.stack.js"></script>
	<script src="<?php echo Yii::app()->theme->baseUrl;?>/js/jquery.flot.resize.min.js"></script>
	<!-- chart libraries end -->

	<!-- select or dropdown enhancer -->
	<script src="<?php echo Yii::app()->theme->baseUrl;?>/js/jquery.chosen.min.js"></script>
	<!-- checkbox, radio, and file input styler -->
	<script src="<?php echo Yii::app()->theme->baseUrl;?>/js/jquery.uniform.min.js"></script>
	<!-- plugin for gallery image view -->
	<script src="<?php echo Yii::app()->theme->baseUrl;?>/js/jquery.colorbox.min.js"></script>
	<!-- rich text editor library -->
	<script src="<?php echo Yii::app()->theme->baseUrl;?>/js/jquery.cleditor.min.js"></script>
	<!-- notification plugin -->
	<script src="<?php echo Yii::app()->theme->baseUrl;?>/js/jquery.noty.js"></script>
	<!-- file manager library -->
	<script src="<?php echo Yii::app()->theme->baseUrl;?>/js/jquery.elfinder.min.js"></script>
	<!-- star rating plugin -->
	<script src="js/jquery.raty.min.js"></script>
	<!-- for iOS style toggle switch -->
	<script src="<?php echo Yii::app()->theme->baseUrl;?>/js/jquery.iphone.toggle.js"></script>
	<!-- autogrowing textarea plugin -->
	<script src="<?php echo Yii::app()->theme->baseUrl;?>/js/jquery.autogrow-textarea.js"></script>
	<!-- multiple file upload plugin -->
	<script src="<?php echo Yii::app()->theme->baseUrl;?>/js/jquery.uploadify-3.1.min.js"></script>
	<!-- history.js for cross-browser state change on ajax -->
	<script src="<?php //echo Yii::app()->theme->baseUrl;?>/js/jquery.history.js"></script>
	<!-- application script for Charisma demo -->
	<script src="<?php //echo Yii::app()->theme->baseUrl;?>/js/charisma.js"></script>
	
		
</body>
</html>
