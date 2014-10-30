<?php

$this->breadcrumbs = array(
	$model->label(2) => array('index'),
	GxHtml::valueEx($model),
);

$this->menu=array(
	array('label'=>Yii::t('app', 'List') . ' ' . $model->label(2), 'url'=>array('index')),
	array('label'=>Yii::t('app', 'Create') . ' ' . $model->label(), 'url'=>array('create')),
	array('label'=>Yii::t('app', 'Update') . ' ' . $model->label(), 'url'=>array('update', 'id' => $model->id)),
	array('label'=>Yii::t('app', 'Delete') . ' ' . $model->label(), 'url'=>'#', 'linkOptions' => array('submit' => array('delete', 'id' => $model->id), 'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>Yii::t('app', 'Manage') . ' ' . $model->label(2), 'url'=>array('admin')),
);
$this->beginWidget('zii.widgets.CPortlet', array(
	'htmlOptions'=>array(
		'class'=>''
	)
));
$this->widget('bootstrap.widgets.TbMenu', array(
	'type'=>'pills',
	'items'=>array(
		array('label'=>'Create', 'icon'=>'icon-plus', 'url'=>Yii::app()->controller->createUrl('create'), 'visible'=>!Yii::app()->user->groupe==3 && !Yii::app()->user->groupe==6,'linkOptions'=>array()),
        array('label'=>'Manage', 'icon'=>'icon-th-list', 'url'=>Yii::app()->controller->createUrl('index'),'visible'=>!Yii::app()->user->groupe==3 && !Yii::app()->user->groupe==6, 'linkOptions'=>array()),
		array('label'=>'List', 'icon'=>'icon-search', 'url'=>Yii::app()->controller->createUrl('admin'),'active'=>true, 'linkOptions'=>array()),
		array('label'=>'Export to PDF', 'icon'=>'icon-download', 'url'=>Yii::app()->controller->createUrl('GeneratePdf'), 'linkOptions'=>array('target'=>'_blank'), 'visible'=>true),
		array('label'=>'Export to Excel', 'icon'=>'icon-download', 'url'=>Yii::app()->controller->createUrl('GenerateExcel'), 'linkOptions'=>array('target'=>'_blank'), 'visible'=>true),
	),
));
$this->endWidget();
?>

<h3><?php echo Yii::t('app', 'View') . ' ' . GxHtml::encode($model->label()) . ' ' . GxHtml::encode(GxHtml::valueEx($model)); ?></h3>

<?php $this->widget('zii.widgets.CDetailView', array(
	'data' => $model,
	'attributes' => array(
'id',
'date',
array(
			'name' => 'idmember0',
			'type' => 'raw',
			'value' => $model->idmember0 !== null ? GxHtml::link(GxHtml::encode(GxHtml::valueEx($model->idmember0)), array('members/view', 'id' => GxActiveRecord::extractPkValue($model->idmember0, true))) : null,
			),
array(
			'name' => 'idhospital0',
			'type' => 'raw',
			'value' => $model->idhospital0 !== null ? GxHtml::link(GxHtml::encode(GxHtml::valueEx($model->idhospital0)), array('hospital/view', 'id' => GxActiveRecord::extractPkValue($model->idhospital0, true))) : null,
			),
'status',
'type',
	),
)); ?>
<?php
if($model->type!=4){
?>
<h4><?php echo GxHtml::encode($model->getRelationLabel('billingDetails')); ?></h4>

<?php
	
	 $this->widget('zii.widgets.grid.CGridView', array(

	//'id' => 'id',
	'dataProvider' => BillingDetails::model()->bill_invoice_accountant($_GET['id']),
	//'filter' => $model,
	'columns' => array(
	     'id',
		'idmedical0.medical_act',
		'quantity',
		array(
			 'name'=>'price',
			 'header'=>'Price (frw)',
			
		),
		array(
			 'name'=>'total',
			 'header'=>'Total (frw)',
			
		),
		array(
			 'name'=>'companyPrice',
			 'header'=>'85% (frw)',
			
		),
		array(
			 'name'=>'insurencePrice',
			 'header'=>'15% (frw)',
			
		),

	),
)); 
	}
?>
<?php
if($model->type==4){
?>
<h4><?php echo GxHtml::encode($model->getRelationLabel('billingDrugs')); ?></h4>

<?php
	
	 $this->widget('zii.widgets.grid.CGridView', array(

	//'id' => 'id',
	'dataProvider' => BillingDrug::model()->bill_invoice_accountant($_GET['id']),
	//'filter' => $model,
	'columns' => array(
	     'id',
		'drug',
		'quantity',
		array(
			 'name'=>'cash',
			 'header'=>'Price (frw)',
			
		),
		array(
			 'name'=>'total',
			 'header'=>'Total (frw)',
			
		),
		array(
			 'name'=>'companyPrice',
			 'header'=>'85% (frw)',
			
		),
		array(
			 'name'=>'insurencePrice',
			 'header'=>'15% (frw)',
			
		),

	),
)); 
	}
?>

