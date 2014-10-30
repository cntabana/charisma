<?php
$model = new users;
$this->breadcrumbs=array(
	'Users',
);

Yii::app()->clientScript->registerScript('search', "
$('.search-button').click(function(){
    $('.search-form').slideToggle('fast');
    return false;
});
$('.search-form form').submit(function(){
    $.fn.yiiGridView.update('users-grid', {
        data: $(this).serialize()
    });
    return false;
});
");

?>

<h1>Change Profile</h1>
<hr />





<div class="search-form" style="display:none">
<?php $this->renderPartial('_search',array(
	'model'=>$model,
)); ?>
</div><!-- search-form -->


<?php
$groupes = array(
    array('value'=>'1', 'text'=>'Clerk Desk of Hospital'),
    array('value'=>'2', 'text'=>'Clerk Desk of Pharmacy'),
    array('value'=>'3', 'text'=>'MIS Accountant'),
    array('value'=>'4', 'text'=>'MIS Admin'),
    array('value'=>'5', 'text'=>'MIS Manager'),
    array('value'=>'6', 'text'=>'MIS Pharmacist')
    );

$status = array(
    array('value'=>'1', 'text'=>'Active'),
    array('value'=>'0', 'text'=>'Inactive')
    
    );

 $this->widget('bootstrap.widgets.TbGridView',array(
	'id'=>'users-grid',
	'dataProvider'=>$model->search(),
        'type'=>'striped bordered condensed',
        'template'=>'{summary}{pager}{items}{pager}',
	'columns'=>array(
		'id',
		array( 
            'class' => 'editable.EditableColumn',
            'name' => 'firstname',
            'editable' => array(
                'type'      => 'text',
                'url'       => $this->createUrl('users/UpdateBooster'),
                'placement' => 'right',
            )
          ),
		array( 
            'class' => 'editable.EditableColumn',
            'name' => 'middlename',
            'editable' => array(
                'type'      => 'text',
                'url'       => $this->createUrl('users/UpdateBooster'),
                'placement' => 'right',
            )
          ),
		array( 
            'class' => 'editable.EditableColumn',
            'name' => 'lastname',
            'editable' => array(
                'type'      => 'text',
                'url'       => $this->createUrl('users/UpdateBooster'),
                'placement' => 'right',
            )
          ),
		'username',
		 array(
                'name'=>'password',
                   'header'=>'Password',
                   'type'=>'raw',
                   'value'=>'CHtml::link("Change Password",Yii::app()->createUrl("users/changepassword", array("id"=>$data["id"])))',
                   
                        
           ),
		/*
		'salt',
		
		*/

	),
)); ?>

