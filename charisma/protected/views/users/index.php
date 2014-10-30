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

<h1>Users</h1>
<hr />

<?php 
$this->beginWidget('zii.widgets.CPortlet', array(
	'htmlOptions'=>array(
		'class'=>''
	)
));
$this->widget('bootstrap.widgets.TbMenu', array(
	'type'=>'pills',
	'items'=>array(
		array('label'=>'Create', 'icon'=>'icon-plus', 'url'=>Yii::app()->controller->createUrl('create'), 'linkOptions'=>array()),
    array('label'=>'List', 'icon'=>'icon-th-list', 'url'=>Yii::app()->controller->createUrl('index'),'active'=>true, 'linkOptions'=>array()),
		array('label'=>'Search', 'icon'=>'icon-search', 'url'=>'#', 'linkOptions'=>array('class'=>'search-button')),
		array('label'=>'Export to PDF', 'icon'=>'icon-download', 'url'=>Yii::app()->controller->createUrl('GeneratePdf'), 'linkOptions'=>array('target'=>'_blank'), 'visible'=>true),
		array('label'=>'Export to Excel', 'icon'=>'icon-download', 'url'=>Yii::app()->controller->createUrl('GenerateExcel'), 'linkOptions'=>array('target'=>'_blank'), 'visible'=>true),
	),
));
$this->endWidget();
?>



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
            'class' => 'editable.EditableColumn',
            'name' => 'groupe',
            'editable' => array(
                'type'      => 'select',
                'url'       => $this->createUrl('users/UpdateBooster'),
                'source'    =>$groupes,
                'placement' => 'right',
            )
          ),
		array( 
            'class' => 'editable.EditableColumn',
            'name' => 'status',
            'editable' => array(
                'type'      => 'select',
                'url'       => $this->createUrl('users/UpdateBooster'),
                 'source'    =>$status,
                'placement' => 'right',
                'options'  => array(    //custom display 
                     'display' => 'js: function(value, sourceData) {
                          var selected = $.grep(sourceData, function(o){ return value == o.value; }),
                              colors = {1: "green", 0: "red"};
                          $(this).text(selected[0].text).css("color", colors[value]);    
                      }'
                  ),
                    //onsave event handler 
                 'onSave' => 'js: function(e, params) {
                      console && console.log("saved value: "+params.newValue);
                 }',
            )
          ),
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

