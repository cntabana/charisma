<?php
/* @var $this SiteController */

$this->pageTitle=Yii::app()->name;
$totalmember=Yii::app()->db->createCommand('select count(*) from members')->queryScalar();
$staffmember=Yii::app()->db->createCommand('select count(*) from members where type=1')->queryScalar();
$studentmember=Yii::app()->db->createCommand('select count(*) from members where type=0')->queryScalar();
$othermember=Yii::app()->db->createCommand('select count(*) from members where type=2')->queryScalar();
?>

<h3>Welcome to <i><?php echo CHtml::encode(Yii::app()->name); ?></i></h3>
<br/>

<div class="sortable row-fluid">
				<a data-rel="tooltip" title="6 new members." class="well span3 top-block" href="#">
					<span class="icon32 icon-red icon-user"></span>
					<div>Total Members</div>
					<div><?php echo $totalmember;?></div>
					<span class="notification">Members</span>
				</a>

				<a data-rel="tooltip" title="<?php echo $staffmember;?> Staffss." class="well span3 top-block" href="#">
					<span class="icon32 icon-red icon-user"></span>
					<div>Staff Members</div>
					<div><?php echo $staffmember;?></div>
					<span class="notification green">Staffs</span>
				</a>

				<a data-rel="tooltip" title="<?php echo $studentmember?> new Students." class="well span3 top-block" href="#">
					<span class="icon32 icon-red icon-user"></span>
					<div>Student Members</div>
					<div><?php echo $studentmember?></div>
					<span class="notification yellow">Students</span>
				</a>
				
				<a data-rel="tooltip" title="<?php echo $othermember;?> Other Members." class="well span3 top-block" href="#">
					<span class="icon32 icon-red icon-user"></span>
					<div>Other members</div>
					<div><?php echo $othermember;?></div>
					<span class="notification red">Others</span>
				</a>
			</div>

				<div class="row-fluid">
				<div class="box span12">
					<div class="box-header well">
						<h2><i class="icon-info-sign"></i> Introduction</h2>
						<div class="box-icon">
							<a href="#" class="btn btn-setting btn-round"><i class="icon-cog"></i></a>
							<a href="#" class="btn btn-minimize btn-round"><i class="icon-chevron-up"></i></a>
							<a href="#" class="btn btn-close btn-round"><i class="icon-remove"></i></a>
						</div>
					</div>
					<div class="box-content">
						<h1>NUR  Mutuelle <small>is web application helps us to manager cards validity and .....</small></h1>
						<p>Its a live demo of the template. I have created Charisma to ease the repeat work I have to do on my projects. Now I re-use Charisma as a base for my admin panel work and I am sharing it with you :)</p>
						<p><b>All pages in the menu are functional, take a look at all, please share this with your followers.</b></p>
						
						<div class="clearfix"></div>
					</div>
				</div>
			</div>

			<div class="row-fluid sortable">
			
			<div class="box span4">
					<div class="box-header well" data-original-title>
						<h2><i class="icon-list"></i> Daily Stat</h2>
						<div class="box-icon">
							<a href="#" class="btn btn-setting btn-round"><i class="icon-cog"></i></a>
							<a href="#" class="btn btn-minimize btn-round"><i class="icon-chevron-up"></i></a>
							<a href="#" class="btn btn-close btn-round"><i class="icon-remove"></i></a>
						</div>
					</div>
					<div class="box-content">
							<ul class="dashboard-list">
							<li>
								<a href="#">
									<i class="icon-arrow-up"></i>                               
									<span class="green">92</span>
									Members                                    
								</a>
							</li>
						  <li>
							<a href="#">
							  <i class="icon-arrow-down"></i>
							  <span class="red">15</span>
							  Traitements
							</a>
						  </li>
						  <li>
							<a href="#">
							  <i class="icon-minus"></i>
							  <span class="blue">36</span>
							  Services                                    
							</a>
						  </li>
						  <li>
							<a href="#">
							  <i class="icon-comment"></i>
							  <span class="yellow">45</span>
							  Lunettes                                    
							</a>
						  </li>
						  <li>
							<a href="#">
							  <i class="icon-arrow-up"></i>                               
							  <span class="green">112</span>
							  Pharmacy                                   
							</a>
						  </li>
						 
						</ul>
					</div>
				</div><!--/span-->
						
			
				<div class="box span4">
					<div class="box-header well" data-original-title>
						<h2><i class="icon-list"></i> Weekly Stat</h2>
						<div class="box-icon">
							<a href="#" class="btn btn-setting btn-round"><i class="icon-cog"></i></a>
							<a href="#" class="btn btn-minimize btn-round"><i class="icon-chevron-up"></i></a>
							<a href="#" class="btn btn-close btn-round"><i class="icon-remove"></i></a>
						</div>
					</div>
					<div class="box-content">
						<ul class="dashboard-list">
							<li>
								<a href="#">
									<i class="icon-arrow-up"></i>                               
									<span class="green">92</span>
									Members                                    
								</a>
							</li>
						  <li>
							<a href="#">
							  <i class="icon-arrow-down"></i>
							  <span class="red">15</span>
							  Traitements
							</a>
						  </li>
						  <li>
							<a href="#">
							  <i class="icon-minus"></i>
							  <span class="blue">36</span>
							  Services                                    
							</a>
						  </li>
						  <li>
							<a href="#">
							  <i class="icon-comment"></i>
							  <span class="yellow">45</span>
							  Lunettes                                    
							</a>
						  </li>
						  <li>
							<a href="#">
							  <i class="icon-arrow-up"></i>                               
							  <span class="green">112</span>
							  Pharmacy                                   
							</a>
						  </li>
						 
						</ul>
					
					</div>
				</div><!--/span-->
					<div class="box span4">
					<div class="box-header well" data-original-title>
						<h2><i class="icon-list"></i> Monthly Stat</h2>
						<div class="box-icon">
							<a href="#" class="btn btn-setting btn-round"><i class="icon-cog"></i></a>
							<a href="#" class="btn btn-minimize btn-round"><i class="icon-chevron-up"></i></a>
							<a href="#" class="btn btn-close btn-round"><i class="icon-remove"></i></a>
						</div>
					</div>
					<div class="box-content">
						<ul class="dashboard-list">
							<li>
								<a href="#">
									<i class="icon-arrow-up"></i>                               
									<span class="green">92</span>
									Members                                    
								</a>
							</li>
						  <li>
							<a href="#">
							  <i class="icon-arrow-down"></i>
							  <span class="red">15</span>
							  Traitements
							</a>
						  </li>
						  <li>
							<a href="#">
							  <i class="icon-minus"></i>
							  <span class="blue">36</span>
							  Services                                    
							</a>
						  </li>
						  <li>
							<a href="#">
							  <i class="icon-comment"></i>
							  <span class="yellow">45</span>
							  Lunettes                                    
							</a>
						  </li>
						  <li>
							<a href="#">
							  <i class="icon-arrow-up"></i>                               
							  <span class="green">112</span>
							  Pharmacy                                   
							</a>
						  </li>
						 
						</ul>
					</div>
				</div><!--/span-->
			</div><!--/row-->

