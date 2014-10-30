<?php
$this->breadcrumbs=array(
	'Manage'=>array('index'),
);?>
<h1> Manage database backup files</h1><br><br>
<div>&nbsp;&nbsp;&nbsp;
<a href='?r=backup/default/index'>List Backup Files</a>&nbsp;&nbsp;&nbsp;
<a href='?r=backup/default/create'>Create Backup File</a>&nbsp;&nbsp;&nbsp;
<a href='?r=backup/default/upload'>Upload Backup File</a>&nbsp;&nbsp;&nbsp;
<a href='?r=backup/default/restore'>Restore Backup File</a>&nbsp;&nbsp;&nbsp;

</div>
<?php $this->renderPartial('_list', array(
		'dataProvider'=>$dataProvider,
));
?>
<?php if(Yii::app()->user->hasFlash('success')):?>
    <div class="alert-success" style="text-align: center; margin: 10px 0 10px 0; padding: 10px;">
        <?php echo Yii::app()->user->getFlash('success'); ?>
    </div>
<?php elseif(Yii::app()->user->hasFlash('error')):?>
    <div class="alert-error" style="text-align: center; margin: 10px 0 10px 0; padding: 10px;">
        <?php echo Yii::app()->user->getFlash('error'); ?>
    </div>
<?php endif; ?>
  
<?php
Yii::app()->clientScript->registerScript(
   'HideAlert',
   '$(".alert-success, .alert-error").animate({opacity: 1.0}, 40000).fadeOut("slow");',
   CClientScript::POS_READY
);
?>