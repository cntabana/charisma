<?php

$this->breadcrumbs = array(
	$model->label(2) => array('index'),
	Yii::t('app', 'Manage'),
);

$this->menu = array(
		array('label'=>Yii::t('app', 'List') . ' ' . $model->label(2), 'url'=>array('index')),
		array('label'=>Yii::t('app', 'Create') . ' ' . $model->label(), 'url'=>array('create')),
	);

Yii::app()->clientScript->registerScript('search', "
$('.search-button').click(function(){
	$('.search-form').toggle();
	return false;
});
$('.search-form form').submit(function(){
	$.fn.yiiGridView.update('invoice-grid', {
		data: $(this).serialize()
	});
	return false;
});
");
$this->beginWidget('zii.widgets.CPortlet', array(
	'htmlOptions'=>array(
		'class'=>''
	)
));
$this->widget('bootstrap.widgets.TbMenu', array(
	'type'=>'pills',
	'items'=>array(
		array('label'=>'Create', 'icon'=>'icon-plus', 'url'=>Yii::app()->controller->createUrl('create'),'visible'=>Yii::app()->user->groupe==1 || Yii::app()->user->groupe==4 || Yii::app()->user->groupe==5, 'linkOptions'=>array()),
        array('label'=>'List', 'icon'=>'icon-th-list', 'url'=>Yii::app()->controller->createUrl('index'),'visible'=>!Yii::app()->user->groupe==3 || !Yii::app()->user->groupe==6, 'linkOptions'=>array()),
		array('label'=>'Manage', 'icon'=>'icon-search', 'url'=>Yii::app()->controller->createUrl('admin'),'active'=>true, 'linkOptions'=>array()),
		array('label'=>'Export to PDF', 'icon'=>'icon-download', 'url'=>Yii::app()->controller->createUrl('GeneratePdf'), 'linkOptions'=>array('target'=>'_blank'), 'visible'=>true),
		array('label'=>'Export to Excel', 'icon'=>'icon-download', 'url'=>Yii::app()->controller->createUrl('GenerateExcel'), 'linkOptions'=>array('target'=>'_blank'), 'visible'=>true),
	),
));
$this->endWidget();
?>

<h3><?php echo Yii::t('app', 'Manage') . ' ' . GxHtml::encode($model->label(2)); ?></h3>


<?php echo GxHtml::link(Yii::t('app', 'Advanced Search'), '#', array('class' => 'search-button')); ?>
<div class="search-form" style="display:none">
<?php $this->renderPartial('_search', array(
	'model' => $model,
)); ?>
</div><!-- search-form -->

<?php

if(Yii::app()->user->groupe==2)
{

 $this->widget('zii.widgets.grid.CGridView', array(
	'id' => 'invoice-grid',
	'dataProvider' => $model->search(),
	'filter' => $model,
	'columns' => array(
		'id',
		
		array(
				'name'=>'idmember',
				'value'=>'GxHtml::valueEx($data->idmember0)',
				'filter'=>GxHtml::listDataEx(Members::model()->findAllAttributes(null, true)),
				),
		array(
        'name'=>'type',
        'value'=>'Invoice::getType($data->type)',
        'filter'=>CHtml::listData(Invoice::getTypes(), 'id', 'type'),
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
			array(
			'class'=>'CButtonColumn',
			'template' =>'{create}',
			'buttons'=>array(
            'create'=>array(
                             'url'=>'Yii::app()->controller->createUrl("billingDrug/create",array("idinvoice"=>$data->id,"type"=>$data->type))',
							  'imageUrl'=>'../charisma/images/add.png',
			),
				
	),
	),
	),
));

}
else if(Yii::app()->user->groupe==6)
{

 $this->widget('zii.widgets.grid.CGridView', array(
	'id' => 'invoice-grid',
	'dataProvider' => $model->search(),
	'filter' => $model,
	'columns' => array(
		'id',
		
		array(
				'name'=>'idmember',
				'value'=>'GxHtml::valueEx($data->idmember0)',
				'filter'=>GxHtml::listDataEx(Members::model()->findAllAttributes(null, true)),
				),
		array(
        'name'=>'type',
        'value'=>'Invoice::getType($data->type)',
        'filter'=>CHtml::listData(Invoice::getTypes(), 'id', 'type'),
        ),
		array(
				'name'=>'idhospital',
				'value'=>'GxHtml::valueEx($data->idhospital0)',
				'filter'=>GxHtml::listDataEx(Hospital::model()->findAllAttributes(null, true)),
				),
		'date',
		'status',
	
			array(
			'class'=>'CButtonColumn',
			'template' =>'{view}',
			'buttons'=>array(
            'view'=>array(
                             'url'=>'Yii::app()->controller->createUrl("invoice/view",array("id"=>$data->id))',
							  'imageUrl'=>'../charisma/images/view.png',
			),
				
	),
	),
	),
));

}
else if(Yii::app()->user->groupe==3)
{

 $this->widget('zii.widgets.grid.CGridView', array(
	'id' => 'invoice-grid',
	'dataProvider' => $model->search(),
	'filter' => $model,
	'columns' => array(
		'id',
		
		array(
				'name'=>'idmember',
				'value'=>'GxHtml::valueEx($data->idmember0)',
				'filter'=>GxHtml::listDataEx(Members::model()->findAllAttributes(null, true)),
				),
		array(
        'name'=>'type',
        'value'=>'Invoice::getType($data->type)',
        'filter'=>CHtml::listData(Invoice::getTypes(), 'id', 'type'),
        ),
		array(
				'name'=>'idhospital',
				'value'=>'GxHtml::valueEx($data->idhospital0)',
				'filter'=>GxHtml::listDataEx(Hospital::model()->findAllAttributes(null, true)),
				),
		'date',
		'status',
	
			array(
			'class'=>'CButtonColumn',
			'template' =>'{view}',
			'buttons'=>array(
            'view'=>array(
                             'url'=>'Yii::app()->controller->createUrl("invoice/view",array("id"=>$data->id))',
							  'imageUrl'=>'../charisma/images/view.png',
			),
				
	),
	),
	),
));

}
else 
{


	$this->widget('zii.widgets.grid.CGridView', array(
	'id' => 'invoice-grid',
	'dataProvider' => $model->search(),
	'filter' => $model,
	'columns' => array(
		'id',
		
		array(
				'name'=>'idmember',
				'value'=>'GxHtml::valueEx($data->idmember0)',
				'filter'=>GxHtml::listDataEx(Members::model()->findAllAttributes(null, true)),
				),
		array(
        'name'=>'type',
        'value'=>'Invoice::getType($data->type)',
        'filter'=>CHtml::listData(Invoice::getTypes(), 'id', 'type'),
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
			array(
			'class'=>'CButtonColumn',
			'template' =>'{create}{update} {view}',
			'buttons'=>array(
            'create'=>array(
                             'url'=>'Yii::app()->controller->createUrl("billingDetails/create",array("idinvoice"=>$data->id,"type"=>$data->type))',
							  'imageUrl'=>'../charisma/images/add.png',
			'visible'=>'$data->type == 2 || $data->type == 1',
			),
			'update'=>array(
                             'url'=>'Yii::app()->controller->createUrl("ordonance/create",array("idinvoice"=>$data->id,"type"=>$data->type))',
							  'imageUrl'=>'../charisma/images/add.png',
			'visible'=>'$data->type == 3',
			),

			'view'=>array(
                             'url'=>'Yii::app()->controller->createUrl("billingDrug/create",array("idinvoice"=>$data->id,"type"=>$data->type))',
							  'imageUrl'=>'../charisma/images/add.png',
			'visible'=>'$data->type == 4',
			),
				
	),
	),
	),
));
}

 ?>