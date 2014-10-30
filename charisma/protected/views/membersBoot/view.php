<?php
$this->breadcrumbs=array(
	'Members Boots'=>array('index'),
	$model->title,
);
?>

<h3>View MembersBoot #<?php echo $model->id; ?></h3>
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
        array('label'=>'List', 'icon'=>'icon-th-list', 'url'=>Yii::app()->controller->createUrl('members/admin'), 'linkOptions'=>array()),
		array('label'=>'Manage', 'icon'=>'icon-th-list', 'url'=>Yii::app()->controller->createUrl('members/index'),'active'=>true, 'linkOptions'=>array()),
		array('label'=>'Print', 'icon'=>'icon-print', 'url'=>'javascript:void(0);return false', 'linkOptions'=>array('onclick'=>'printDiv();return false;')),

		),
));
$this->endWidget();
?>
</hr>

<div class='printableArea' style='width:70%'>

<?php $this->widget('editable.EditableDetailView',array(
	'data'=>$model,
	'url'        => $this->createUrl('members/UpdateBooster'), //common submit url for all fields
    //'params'     => array('YII_CSRF_TOKEN' => Yii::app()->request->csrfToken), //params for all fields
    'emptytext'  => 'no value',
     'mode'      => 'inline',
    //'apply' => false, //you can turn off applying editable to all attributes

	'attributes'=>array(
		'id',
		'cardnumber',
		'firstname',
     	'middlename',
		'lastname',
		'issuedate',
		'expireddate',
		'birthday',
		array( //select loaded from database
            'name' => 'sex',
            'editable' => array(
                'type'   => 'select',
                'source'=>MembersBoot::model()->getGender(),
             )
        ),
		'phonenumber',
		'address',
		'email',
		array( //select loaded from database
            'name' => 'iddistrict',
            'editable' => array(
                'type'   => 'select',
                //'source'=>editable::source(District::model()->findAll(),'id', 'district'),
             )
        ),
		array( //select loaded from database
            'name' => 'idsector',
            'editable' => array(
            'type'   => 'select',
            //'source'=>editable::source(Sector::model()->findAll(),'id', 'sector'),
             )
        ),

		
		'nationality',
		array( //select loaded from database
            'name' => 'status',
            'editable' => array(
                'type'   => 'select',
                'source'=>MembersBoot::model()->getStatus(),
             )
        ),
		array( //select loaded from database
            'name' => 'type',
            'editable' => array(
                'type'   => 'select',
                'source'=>MembersBoot::model()->getType(),
             )
        ),
		'photo',
		'title',
	),
)); ?>
</div>
<style type="text/css" media="print">
body {visibility:hidden;}
.printableArea{visibility:visible;} 
</style>
<script type="text/javascript">
function printDiv()
{

window.print();

}
</script>
