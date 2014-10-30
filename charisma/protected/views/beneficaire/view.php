<?php

$this->breadcrumbs = array(
	$model->label(2) => array('index'),
	GxHtml::valueEx($model),
);

$this->menu=array(
	array('label'=>Yii::t('app', 'Manage') . ' ' . $model->label(2), 'url'=>array('index')),
	array('label'=>Yii::t('app', 'Create') . ' ' . $model->label(), 'url'=>array('create')),
	array('label'=>Yii::t('app', 'Update') . ' ' . $model->label(), 'url'=>array('update', 'id' => $model->id)),
	array('label'=>Yii::t('app', 'Delete') . ' ' . $model->label(), 'url'=>'#', 'linkOptions' => array('submit' => array('delete', 'id' => $model->id), 'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>Yii::t('app', 'List') . ' ' . $model->label(2), 'url'=>array('admin')),
);
?>
<h3><?php echo Yii::t('app', 'View') . ' ' . GxHtml::encode($model->label()) . ' ' . GxHtml::encode(GxHtml::valueEx($model)); ?></h3>
<hr>
<?php 
$this->beginWidget('zii.widgets.CPortlet', array(
	'htmlOptions'=>array(
		'class'=>''
	)
));
$this->widget('bootstrap.widgets.TbMenu', array(
	'type'=>'pills',
	'items'=>array(
		array('label'=>'List', 'icon'=>'icon-th-list', 'url'=>Yii::app()->controller->createUrl('admin'), 'linkOptions'=>array()),
		array('label'=>'Manage', 'icon'=>'icon-th-list', 'url'=>Yii::app()->controller->createUrl('index'),'visible'=>Yii::app()->user->groupe!=1 && Yii::app()->user->groupe!=2,'active'=>true, 'linkOptions'=>array()),
		array('label'=>'Formulaire des sois du patient', 'icon'=>'icon-th-list', 'url'=>Yii::app()->controller->createUrl('beneficaire/formulaire',array('id'=>$_GET['id'])),'visible'=>Yii::app()->user->groupe!=2, 'linkOptions'=>array()),
        array('label'=>'Ordonnance Medicale', 'icon'=>'icon-th-list', 'url'=>Yii::app()->controller->createUrl('beneficaire/ordonnanceMedicale',array('id'=>$_GET['id'])),'visible'=>Yii::app()->user->groupe!=2, 'linkOptions'=>array()),
        array('label'=>'Medical spectacle prescription', 'icon'=>'icon-th-list', 'url'=>Yii::app()->controller->createUrl('beneficaire/lunette',array('id'=>$_GET['id'])), 'visible'=>Yii::app()->user->groupe!=2,'linkOptions'=>array()),
        array('label'=>'Bullettin d\'analyse', 'icon'=>'icon-th-list', 'url'=>Yii::app()->controller->createUrl('beneficaire/analyseDemande',array('id'=>$_GET['id'])),'visible'=>Yii::app()->user->groupe!=2, 'linkOptions'=>array()),
        array('label'=>'Print', 'icon'=>'icon-print', 'url'=>'javascript:void(0);return false', 'linkOptions'=>array('onclick'=>'printDiv();return false;')),

		),
));
$this->endWidget();
?>
</hr>
<?php $this->widget('zii.widgets.CDetailView', array(
	'data' => $model,
	'attributes' => array(
'id',
array(        
        'name'=>'photo',
        'type'  => 'raw',
         'value'=> CHtml::image(Yii::app()->request->baseUrl.'/pictures/'.$model->photo,"photo",array("width"=>200)),
     ),

'firstname',
'middlename',
'lastname',
'dateofbirth',
array(
           'name'=>'sex',
           'type'=>'raw',
           'value'=>(CHtml::encode($model->sex)== 0)? "<span >Male</span>":"<span >Female</span>",
        ),
array(
			'name' => 'idmember0',
			'type' => 'raw',
			'value' => $model->idmember0 !== null ? GxHtml::link(GxHtml::encode(GxHtml::valueEx($model->idmember0)), array('members/view', 'id' => GxActiveRecord::extractPkValue($model->idmember0, true))) : null,
			),
array(
           'name'=>'type',
           'type'=>'raw',
           'value'=>(CHtml::encode($model->type)== 1)? "<span >Conjoint</span>":"<span >Child</span>",
        ),

	),
)); ?>

