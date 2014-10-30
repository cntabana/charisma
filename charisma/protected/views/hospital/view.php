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
		array('label'=>'Create', 'icon'=>'icon-plus', 'url'=>Yii::app()->controller->createUrl('create'), 'linkOptions'=>array()),
                array('label'=>'List', 'icon'=>'icon-th-list', 'url'=>Yii::app()->controller->createUrl('index'),'active'=>true, 'linkOptions'=>array()),
		array('label'=>'Manage', 'icon'=>'icon-search', 'url'=>Yii::app()->controller->createUrl('admin'), 'linkOptions'=>array('class'=>'search-button')),
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
'hopitalName',
'address',
array(
           'name'=>'type',
           'type'=>'raw',
           'value'=>(CHtml::encode($model->type)== 0)? "<span>Hospital</span>":"<span>Pharmacy</span>",
        ),
array(
			'name' => 'iduser0',
			'type' => 'raw',
			'value' => $model->iduser0 !== null ? GxHtml::link(GxHtml::encode(GxHtml::valueEx($model->iduser0)), array('users/view', 'id' => GxActiveRecord::extractPkValue($model->iduser0, true))) : null,
			),
	),
)); ?>
<hr>
<h4><?php echo GxHtml::encode($model->getRelationLabel('invoices')); ?></h4>
<hr>
<?php


   $count=Yii::app()->db->createCommand('SELECT COUNT(*) FROM invoice where idhospital='.$_GET['id'])->queryScalar();
   $sql='SELECT id,
           case
           when type = 1 then "Analyse"
           when type = 2 then "Traitement"
           when type = 3 then "Lunette"
           else "Pharmacy"
           end type,
           date FROM invoice where idhospital='.$_GET['id'];
   
    $dataProvider=new CSqlDataProvider($sql, array(
    'totalItemCount'=>$count,
    'sort'=>array(
        'attributes'=>array(
             'id', 'date', 'type',
        ),
    ),
    'pagination'=>array(
        'pageSize'=>10,
    ),
));


	 $this->widget('zii.widgets.grid.CGridView', array(
	'id' => 'invoice-grid',
	'dataProvider' => $dataProvider,
	'columns' => array(
		'id',
		'type',
		'date',
		/*array(
				'name'=>'idmember',
				'value'=>'GxHtml::valueEx($data->idmember0)',
				//'filter'=>GxHtml::listDataEx(Members::model()->findAllAttributes(null, true)),
				),
		array(
        'name'=>'type',
        'value'=>'Traitement::getType($data->type)',
        'filter'=>CHtml::listData(Traitement::getTypes(), 'id', 'type'),
        ),
		array(
				'name'=>'idhospital',
				'value'=>'GxHtml::valueEx($data->idhospital0)',
				'filter'=>GxHtml::listDataEx(Hospital::model()->findAllAttributes(null, true)),
				),
		'date',
		'status',
		array(
			'class' => 'CButtonColumn',
		),
*/
	),
)); 
?>